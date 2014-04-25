class ClubsController < ApplicationController
  before_action :set_club, only: [:show, :edit, :update, :destroy]

  # load_and_authorize_resource
  # skip_authorize_resource :only => [:index,:show,:tables_status,:catalog]

  #ID_UNEXIT_CLUB = 1000000

  def catalog
    params[:price] ||= {:from=>0, :to => 999999999999999999}
    @clubs = (params[:name] && !params[:name].blank?) ? Club.where(name: params[:name]) : Club.all
    @clubs = @clubs.where(:submited => true)
    if params[:property_ids]
      ids = Property.where(:id => params[:property_ids])
                    .map{|p| p.club_ids}
                    .flatten
                    .uniq
      @clubs = @clubs.where(:id => ids)
              .where(average_price: params[:price][:from]..params[:price][:to])
    end
    params[:order_by] ||= :rating_average
    @clubs = @clubs.order(params[:order_by].to_sym => :desc)
    @checked_properties = (params[:property_ids] || []).map{|i| i.to_i}
    respond_to do |format|
      format.js
      format.html
    end
  end

  def round_f f, x
    Proc.new{(x/ f.to_f).round * f}
  end

  def tables_status
    @club = Club.find(params[:club_id])
    @tables = @club.table
    # params[:date] ||= Date.today.strftime('%d.%m.%Y')
    # params[:hour] ||= Time.now.hour.to_s
    # params[:minute] ||= Time.now.min.to_s
    # @time = Time.parse params[:date]+' '+params[:hour]+':'+round_5_min(params[:minute].to_i).to_s
    @table_id = (params[:order] || {:table_id => 0})[:table_id].to_i
  end

  def rate
    @club = Club.find(params[:id])
    @club.rate(params[:stars], current_user, params[:dimension])
    @club.update_cached_average
  end

  # GET /clubs
  # GET /clubs.json
  def index
    @clubs = Club.all
    @clubs = @clubs.where(:submited => true)
  end

  # GET /clubs/1
  # GET /clubs/1.json
  def show
  end

  # GET /clubs/new
  def new
    @club = Club.new
    @club
  end

  # GET /clubs/1/edit
  def edit
    return render 'new'
  end

  # POST /clubs
  # POST /clubs.json
  def create
    @club = Club.new
    #@club = current_user.clubs.build
    @club.tables_count = 0
    @club.properties = Property.find(params[:property_ids])
    respond_to do |format|
      if @club.update(club_params)
        @club.submited = true
        photos = Photo.find session[:photos_for_req_club]
        #photos.map { |photo| photo.imageable_id = @club.id; photo.update! }
        @club.photos << photos
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
    @club.properties << Property.find_by_name_ru(params[:club_type])
    respond_to do |format|
      if @club.update(club_params)
        photos = Photo.find session[:photos_for_req_club]
        @club.photos << photos
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
      if not @club.submited
        not_found
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def club_params
      #params.require(:club).permit(:photos_attributes).permit!
      params.require(:club).permit!
      #({
        # :photos_attributes => 
        #   [:photo => [] ]
        # },:dimension,:stars, :show_user_rating, :name, :tables_count, :description, :time_before, :time_after, :time_last)
    end
end