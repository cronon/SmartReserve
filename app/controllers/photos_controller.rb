class PhotosController < ApplicationController
  #POST /clubs/2/photos
  def create
    blog_image = Photo.new
    blog_image.image = params[:photo_form][:uploaded_data]
    blog_image.save!
 
  # TODO: store blog_image.id in session OR pass ID back to form for storage in a hidden field
  # OR if your main resource already exists, mount the uploader to it directly and go sip on a 
  # pina colada instead of worrying about this 
    render :text => blog_image.image.url
  end
end