class PagesController < ApplicationController
  def cap
    if current_user
      @clubs = Club.all
      render 'clubs/index'
    else
      render :layout=> false
    end
  end

  def about
  end
end