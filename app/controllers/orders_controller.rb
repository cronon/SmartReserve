class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource
  skip_authorize_resource :only => [:index,:show]

  #for user, which off js in brouser
  def new
    @table = Table.find params[:table_id]
    respond_to do |format|
      format.js
    end
  end

  # need year, month, day, hour, minute, phone, name, table_id
  def prepare
    @order = Order.prepare :table_id => order_params[:table_id], :time => Time.parse(order_params[:time]), :phone => order_params[:phone], :name => order_params[:name]
    @club = Club.find params[:club_id]
    @tables = @club.table
    @order.confirmation_code = ""
    respond_to do |format|
      format.js
    end
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
    @order = Order.new 
    @club = Club.find params[:club_id]
    @tables = @club.table
    if current_user
      @order.name = current_user.name
      @order.phone = current_user.phone
    else
      @order.phone = '+375'
    end
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
    respond_to do |format|
      if @order.save
        format.js {render action: 'create', notice: 'Order was successfully created.'}
        format.html { redirect_to club_order_url(@order.table.club, @order), notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.js
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
    respond_to do |format|
      format.html { redirect_to club_tables_url(@order.table.club) }
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
      params.require(:order).permit(:table_id, :since, :until, :time, :year, :month, :day, :hour,:minute, :name, :phone, :token, :confirmation_code)
    end

    def parse_time params
      puts params
      Time.new(params[:year].to_i, params[:month].to_i, params[:day].to_i, params[:hour].to_i, params[:minute].to_i)
    end
end
