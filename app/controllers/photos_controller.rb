class PhotosController < ApplicationController
  #POST /clubs/2/photos
  def create
    photo = Photo.new
    photo.image = params[:photo][:uploaded_data]
    photo.club_id = params[:club_id]
    photo.save!
 
  # TODO: store photo.id in session OR pass ID back to form for storage in a hidden field
  # OR if your main resource already exists, mount the uploader to it directly and go sip on a 
  # pina colada instead of worrying about this 
    render :text => photo.image.url
  end
end