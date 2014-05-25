class Invite < ActiveRecord::Base
	after_save :send_invite_on_email

	def send_invite_on_email
		pass = SecureRandom.hex.to_s[0...8]
  	invite = Invite.last
  	user = User.new(email: invite[:email], phone: invite[:phone],
  	 name: invite[:name], password: pass) 
  	puts "User = #{user.email}"
  	user.save!

  	letter = 'Your invite on smartresserve.by: '
  	InviteMailer.send_mail(user, letter, pass,
  	 'http://google.by').deliver
	end
end
