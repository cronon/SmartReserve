class PhotosController < ApplicationController
  #POST /clubs/2/photos
  def create
    @photo = Photo.new
    @photo.image = params[:file]
    @photo.club_id = params[:club_id]
    @photo.save!
 
  # TODO: store photo.id in session OR pass ID back to form for storage in a hidden field
  # OR if your main resource already exists, mount the uploader to it directly and go sip on a 
  # pina colada instead of worrying about this 
  end

  def destroy    
    @photo = Photo.find(params[:id]).destroy
  end
end