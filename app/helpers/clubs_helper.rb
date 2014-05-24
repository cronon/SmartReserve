module ClubsHelper

  def time_selector name, klass="time-select"
    s=""
    s <<"<select name='#{name}[hour]' class='#{klass}'>"
    ('00'..'23').each do |k|
      s << "<option value=#{k} name='#{name}[hour]'></option>"
    end
    s <<"<select name='#{name}[minute]' class='#{klass}'>"
    ('00'..'55').each do |k|
      if k.to_i % 5 == 0
        s << "<option value=#{k} name='#{name}[minute]'></option>"
      end
    end
    s.html_safe
  end

  def top_right_icon_src club
    if club.certified?
      asset_url 'top_right_icons/certified.png'
    elsif (Time.now - club.created_at) < 2.weeks
      asset_url 'top_right_icons/new.png'
    elsif club.name == 'Stopline' #not club.discounts.blank?
      asset_url 'top_right_icons/discount.png'
    else
      false
    end
  end  
end
