class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource
  skip_authorize_resource :only => [:index,:show,:prepare,:create,:new,
    :get_new_orders, :by_interval, :journal_by_inteval]

  @@UNDEFINED_LOWER_MINUTE = -1

  def get_new_orders
    @orders = Club.find(params[:club_id]).orders
    @orders = @orders.where('created_at > ?', Time.parse(params[:last_time])+5.seconds).order(:created_at => :desc)
  end

  def prepare
    @time = parse_time(params)
    @order = Order.prepare :table_id => order_params[:table_id], :time => @time, :phone => order_params[:phone], :name => order_params[:name]
    @order.comment = order_params[:comment]
    @club = Club.find params[:club_id]
    @tables = @club.table
    #@order.confirmation = ""
    respond_to do |format|
      format.js
    end
  end
  # GET /orders
  # GET /orders.json
  def index
    @club = Club.find(params[:club_id])
    @orders = @club.orders.per_today
    params[:interval] = 'today'
    @start_day = Time.now
    #тут должны быть начало и конец рабочего дня, но пока говном
    day = Time.now
    @times_lower_table_stat = Order.calculate_params_lower_stat_table(day.beginning_of_day,
     day.end_of_day)
  end

  #GET /by_interval?data_start=24.04.2014&data_end=25.04.2014
  def by_interval
    @club = Club.find(params[:club_id])
    if params[:interval].nil?
      @date_start = DateTime.parse("#{params[:date_start]} 00:00:00")
      @date_end   = DateTime.parse("#{params[:date_end]} 00:00:00")
    else
      @date_start = Order.intervals[params[:interval].to_sym].first
      @date_end   = Order.intervals[params[:interval].to_sym].second
    end
    @orders = @club.orders.per_interval @date_start, @date_end
    respond_to do |format|
      format.js
    end
  end

  #GET /journal_by_inteval?date_day=24.04.2014&start_time=3&end_time=23
  def journal_by_inteval
    @club = Club.find(params[:club_id])
    min = '00'
    min = params[:lower_minute] if (params[:lower_minute].to_i != -1) && (!params[:lower_minute].nil?) 
    
    @start_day = Time.parse("#{params[:day_date]} #{params[:start_time]}:00:00")
    @end_day   = Time.parse("#{params[:day_date]} #{params[:end_time]}:#{min}:00")

    @times_lower_table_stat = Order.calculate_params_lower_stat_table(@start_day, @end_day)

    respond_to do |format|
      format.js
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end  
  
  def new
    @order = Order.new 
    @club = Club.find params[:club_id]
    @tables = @club.table
    if current_user
      @order.name = current_user.name
      @order.phone = current_user.phone
    else
      @order.phone = '+375'
    end
    # params[:date] ||= Date.today.strftime('%d.%m.%Y')
    # params[:hour] ||= Time.now.hour.to_s
    # params[:minute] ||= Time.now.min.to_s
    # @time = Time.parse params[:date]+' '+params[:hour]+':'+round_5_min(params[:minute].to_i).to_s
  end

  # POST /orders
  # POST /orders.json
  # needs club_id, table_id, time, phone, confiramation_code, token
  def create
    club = Club.find params[:club_id]
    table = Table.find order_params[:table_id]
    time = Time.parse(order_params[:time])
    @order = Order.new order_params
    @order.validate_code
    o = table.new_order_at(time)
    @order.until = o.until
    @order.since = o.since 
    @order.time = Time.parse(order_params[:time])
    @order.user = current_user
    respond_to do |format|
      if @order.save
        format.js {render action: 'create', notice: 'Order was successfully created.'}
        format.html { redirect_to club_news_index_path(club, @order), notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.js
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @order.user = current_user
    respond_to do |format|
      if @order.update!(order_params)
        format.html { redirect_to club_order_url(@order.table.club, @order), notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit!
    end

    def parse_time params
      Time.parse(params[:date]+' '+params[:hour]+':'+params[:minute])
    end
end
