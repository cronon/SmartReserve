class Invite < ActiveRecord::Base
	after_save :send_invite_on_email

	def send_invite_on_email
		pass = SecureRandom.hex.to_s[0...8]
  	invite = Invite.last
  	user = User.new(email: invite[:email], phone: invite[:phone],
  	 name: invite[:name], password: pass, :owner_clubs => true) 
  	puts "User = #{user.email}"
  	user.save!
  	subject = 'Your invite on smartresserve.by'
  	InviteMailer.send_mail(user, subject, pass).deliver
	end
end
