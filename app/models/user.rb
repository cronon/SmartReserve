class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :comments
  has_many :clubs
  mount_uploader :avatar, ImageUploader
  ajaxful_rater

  has_many :favorites
  has_many :favorite_clubs, :through => :favorites

  has_many :subscribes
  has_many :subscribed_clubs, :through => :subscribes

  include ApplicationHelper
  def avatar_url
    if self.avatar.url
      to_http self.avatar.url
    else
      ActionController::Base.helpers.asset_url("avatars/no_avatar.png")
    end
  end

  def active_for_authentication?
    true
  end
end
