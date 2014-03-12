class TablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource
  skip_authorize_resource :only => [:index,:show]

  # GET /tables
  # GET /tables.json
  def index
    @tables = Club.find(params[:club_id]).table
    @time = Time.now
    @order = Order.new
  end

  # GET /tables/1
  # GET /tables/1.json
  def show
    @table = Table.find params[:id]
  end

  # GET /tables/1/edit
  def edit
    @table = Table.find params[:id]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def table_params
      params.require(:table).permit(:club_id)
    end
end
