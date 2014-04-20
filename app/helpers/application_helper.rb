module ApplicationHelper

  # breadcrumbs('->',{'Main'=>'/','Catalog'=>'/clubs','Stopline'=>'/15','Edit'=>'/edit'}) =>
  # Main->Catalog->Stopline->Edit
  def breadcrumbs separator, crumbs
    content_tag(:span, class: 'breadcrumbs-span') do
      url=''
      crumbs.map do |name,link|
        url += link
        l=link_to sanitize(name), sanitize(url)
        url = '' if url=='/'
        l
      end.join(separator).html_safe
    end
  end

  def to_http s#from https
    'http://'+s[8..-1]
  end

  #dima:  try this -> time.strftime('%d.%m.%Y')
  #Wed, 16 Apr 2014 20:02:29 FET +03:00 to 16.04.2014
  def utc_to_year_mounth_day time
  	year_mounth_day = time.utc.to_s.split(" ").first
  	parts = year_mounth_day.split("-")
  	parts.reverse.join(".")
  end

	#return closet index '.' in str or index if '.' not include in str
  def index_closet_point_to(str, index)
  	less_index = str.index('.')
  	old_less_index = less_index
  	while !less_index.nil? && less_index < index 
  		old_less_index = less_index
  		less_index = str.index('.', old_less_index + 1)
  	end

  	if old_less_index.nil?
  		index
  	else
  		old_less_index
  	end
  end
end
