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

  def active_for_authentication?
    true
  end
end
