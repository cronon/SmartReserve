class InviteMailer < ActionMailer::Base
  default from: "no-reply@smartreserve.by"

  def send_mail(user, letter, pass, sign_in_link)
  	@user = user
  	@pass = pass
  	@sign_in_invite = sign_in_link
  	mail(to: @user.email, subject: letter)
  end
end
