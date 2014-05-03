class Subscribe < ActiveRecord::Base
  belongs_to :subscribed_club, :class_name => "Club", :foreign_key => 'club_id'
  belongs_to :subscribed_user, :class_name => "User", :foreign_key => 'user_id'
end
