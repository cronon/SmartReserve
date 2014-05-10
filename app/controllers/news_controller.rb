class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  def create
    @news = News.new(news_params)
    @news.club_id = params[:club_id]
    respond_to do |format|
      if @news.save
        format.html { redirect_to club_news_index_url(@news), notice: 'News was successfully created.' }
        format.json { render action: 'show', status: :created, location: @news }
      else
        format.html { render action: 'new' }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to :back, notice: 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to :back }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @news = News.new
  end

  def show
  end
  def index
    @news = News.where(:club_id => params[:club_id])
  end

  def destroy    
    @news.destroy
  end

  #свернуть/развернуть
  def news_full
    @one_news = News.where(:id => params[:id]).first
    puts "params = #{params}"
    puts "NEWS = #{@one_news}"
    respond_to do |format|
      if params[:mode] == "get_full"
        format.js{ render "news_full"}
      else
        format.js{ render "news_roll_up"}
      end
    end
  end

  private
    def set_news
      @news = News.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:description, :title,:avatar, :avatar_cache)
    end
end
