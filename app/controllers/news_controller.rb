class NewsController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy]

  def create
    @news = News.new(news_params)
    @news.club_id = params[:club_id]
    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'Club was successfully created.' }
        format.json { render action: 'show', status: :created, location: @news }
      else
        format.html { render action: 'new' }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clubs/1
  # PATCH/PUT /clubs/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, notice: 'Club was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

  end
  def new
    @news = News.new
  end

  def show
  end
  def index
    @news = News.find_all_by_club_id params[:club_id]
  end

  def destroy    
    @news.destroy
  end

  private
    def set_news
      @news = News.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:description, :title)
    end
end
