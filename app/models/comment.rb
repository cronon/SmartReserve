class Comment < ActiveRecord::Base
  belongs_to :club
  belongs_to :user

  attr_accessor :description
end
