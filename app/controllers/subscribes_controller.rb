class SubscribesController < ApplicationController
  def create
    ids = Club.find_all_by_name(params[:club_names]).map{|c| c.id}
    ids.each do |id| 
      (current_user.subscribes.build :club_id =>id).save
    end
  end

  def destroy
    if @f = current_user.subscribes.find_by_club_id(params[:id])
      @f.destroy
    end
  end
end