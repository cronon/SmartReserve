module ApplicationHelper

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def flash_normal
   render "layouts/messages"
  end

  def resource_name
   :user
  end

  def resource
   @resource ||= User.new
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
  end

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
    if s[0..7] == "https://" 
      'http://'+s[8..-1]
    else
      s
    end
  end

  #dima:  try this -> time.strftime('%d.%m.%Y')
  #Wed, 16 Apr 2014 20:02:29 FET +03:00 to 16.04.2014
  def utc_to_year_mounth_day time
  	year_mounth_day = time.utc.to_s.split(" ").first
  	parts = year_mounth_day.split("-")
  	parts.reverse.join(".")
  end

  #for news
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
