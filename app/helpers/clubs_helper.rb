module ClubsHelper
  def top_right_icon_src club
    if club.certified?
      asset_path 'top_right_icons/certified.png'
    elsif (Time.now - club.created_at) < 2.weeks
      asset_path 'top_right_icons/new.png'
    elsif club.name == 'Stopline' #not club.discounts.blank?
      asset_path 'top_right_icons/discount.png'
    else
      ''
    end
  end  
end
