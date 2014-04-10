class News < ActiveRecord::Base
  belongs_to :club
  has_many :photos, :as => :imageable
end