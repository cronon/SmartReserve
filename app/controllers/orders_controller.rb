class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  #for user, which off js in brouser
  def new
    @table = Table.find params[:table_id]
    respond_to do |format|
      format.js
    end
  end

  def prepare
    @order = Order.new :table_id => params[:order][:table_id], :time => parse_time(params[:time]), :phone => params[:phone], :name => params[:name]
    @order.token = Time.now.nsec*rand() % 1000000
    send_sms(@order.phone)
    render action: 'approve'
  end
  # GET /orders
  # GET /orders.json
  def index
    @orders = Club.find(params[:club_id]).table.map{|t| t.order}.flatten
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end  

  def new
    puts params
    @order = Order.new 
    @table = Table.find params[:id]
    @club = Club.find params[:club_id]
  end

  # POST /orders
  # POST /orders.json
  def create
    club = Club.find params[:club_id]
    table = Table.find params[:order][:table_id]
    time = parse_time params[:time]
    # @order.table = table
    # if table.status(time) == :free and club.whether_order?(time)   
    #   @order.since = time - club.time_before
    #   @order.since = Time.now if @order.since < Time.now
    #   @order.until = time + club.time_after
    # else
    #   puts table.status(time), club.whether_order?(time)
    # end
    @order = table.new_order_at time
    respond_to do |format|
      if @order.save
        format.js
        format.html { redirect_to club_order_url(@order.table.club, @order), notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
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
    @order.destroy
    respond_to do |format|
      format.html { redirect_to club_tables_url(@order.table.club) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:table_id, :since, :until, :time)
    end

    def parse_time params
      Time.new(params[:year].to_i, params[:month].to_i, params[:day].to_i, params[:hour].to_i, params[:minute].to_i)
    end
end
