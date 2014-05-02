class Favorite < ActiveRecord::Base
  belongs_to :favorite_club, :class_name => "Club", :foreign_key => 'club_id'
  belongs_to :favorite_user, :class_name => "User", :foreign_key => 'user_id'
end
