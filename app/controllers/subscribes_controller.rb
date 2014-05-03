class SubscribesController < ApplicationController
  def create
    current_user.subscribes.build :club_id => params[:club_id]
  end

  def destroy
    if @f = current_user.subscribes.find_by_club_id(params[:id])
      @f.destroy
    end
  end
end