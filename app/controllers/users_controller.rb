class UsersController < ApplicationController
  
	load_and_authorize_resource
  skip_authorize_resource :only => [:index,:show,:profile]

  def profile
  	#need for can? :create, @club
  	@club = Club.new    
  end
end
