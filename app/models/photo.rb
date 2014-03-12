class Photo < ActiveRecord::Base
  belongs_to :club
  mount_uploader :image, ImageUploader
end
