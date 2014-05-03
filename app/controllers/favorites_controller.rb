class FavoritesController < ApplicationController
  def create
    current_user.favorites.build :club_id => params[:club_id]
  end

  def destroy
    if @f = current_user.favorites.find_by_club_id(params[:id])
      @f.destroy
    end
  end
end