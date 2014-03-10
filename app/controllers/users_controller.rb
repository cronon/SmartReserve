class UsersController < ApplicationController
  def profile
  	#need for can? :create, @club
  	@club = Club.new
  end
end
