class PagesController < ApplicationController
  def cap
    if current_user
      @clubs = Club.all
      @clubs = @clubs.where(:submited => true)
      render 'clubs/index'
    else
      render :layout=> false
    end
  end

  def about
  end
end