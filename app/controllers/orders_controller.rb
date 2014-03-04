class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  #for user, which off js in brouser
  def new
    @table = Table.where(id: params[:table_id]).first
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

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new
    club = Club.find params[:club_id]
    table = Table.find params[:id]
    time = Time.parse params[:time]
    @order.table = table
    if table.status(time) == :free and club.whether_order?(time)   
      @order.since = time - club.time_before
      @order.since = Time.now if @order.since < Time.now
      @order.until = time + club.time_after
    end
    respond_to do |format|
      if @order.save
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
      params.require(:order).permit(:table_id, :since, :until)
    end
end
