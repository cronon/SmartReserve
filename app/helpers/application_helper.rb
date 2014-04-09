module ApplicationHelper
    def to_http s#from https
      'http://'+s[8..-1]
    end
end
