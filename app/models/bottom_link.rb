class BottomLink < ActiveRecord::Base
	belongs_to :category_link

	#URI.parse(uri) на случай, если сие не будет работать
 	def normalize_link
		with_http_or_https = (self.src =~ /^http[s]{0,1}\:\/\//)
		if with_http_or_https.nil?
			self.src = 'http://' + self.src
			self.save!
		end
		self.src
	end

end
