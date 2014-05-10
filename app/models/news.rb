class News < ActiveRecord::Base
  belongs_to :club
  mount_uploader :avatar, ImageUploader
  has_many :photos, :as => :imageable

  include ApplicationHelper
  def avatar_url
    if self.avatar.url
      to_http self.avatar.url
    else
      ActionController::Base.helpers.asset_url("avatars/no_avatar.png")
    end
  end
end