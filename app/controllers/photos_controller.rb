class PhotosController < ApplicationController
  #POST /clubs/2/photos
  def create
    if params[:type] == "club"
      club = Club.find(params[:club_id])
      @photo = club.photos.build
    else params[:type] == "news"
      news = News.find(params[:news_id])
      @photo = news.photos.build
    end
    @photo.image = params[:file]
    @photo.save!
 
  # TODO: store photo.id in session OR pass ID back to form for storage in a hidden field
  # OR if your main resource already exists, mount the uploader to it directly and go sip on a 
  # pina colada instead of worrying about this 
  end

  def destroy    
    @photo = Photo.find(params[:id]).destroy
  end
end