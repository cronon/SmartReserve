class ClubsController < ApplicationController
  before_action :set_club, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource
  skip_authorize_resource :only => [:index,:show,:tables_status]


  def tables_status
    @tables = Club.find(params[:club_id]).table
    @time = Time.parse params[:order][:time]
    @table_id = params[:order][:table_id].to_i
  end

  def rate
    @club = Club.find(params[:id])
    @club.rate(params[:stars], current_user, params[:dimension])
  end

  # GET /clubs
  # GET /clubs.json
  def index
    @clubs = Club.all
  end

  # GET /clubs/1
  # GET /clubs/1.json
  def show
  end

  # GET /clubs/new
  def new
    @club = Club.new
  end

  # GET /clubs/1/edit
  def edit
  end

  # POST /clubs
  # POST /clubs.json
  def create
    puts '###########'
    photos = params[:club][:photos].map!{|u| Photo.new u}
    puts '###########'
    @club = current_user.clubs.build(club_params)
    @club.properties = Property.find(params[:property_ids])
    respond_to do |format|
      if @club.save
        format.html { redirect_to edit_club_path(@club), notice: 'Club was successfully created.' }
        format.json { render action: 'show', status: :created, location: @club }
      else
        format.html { render action: 'new' }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clubs/1
  # PATCH/PUT /clubs/1.json
  def update
    @club.properties = Property.find(params[:property_ids])
    respond_to do |format|
      if @club.update(club_params)
        format.html { redirect_to @club, notice: 'Club was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.json
  def destroy
    @club.destroy
    respond_to do |format|
      format.html { redirect_to clubs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = Club.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def club_params
      params.permit(photo: [])
      params.require(:club).permit(:dimension,:stars, :show_user_rating, :name, :tables_count, :description, :time_before, :time_after, :time_last)
    end
end