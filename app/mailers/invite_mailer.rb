class InviteMailer < ActionMailer::Base
  default from: "no-reply@smartreserve.by"

  def send_mail(user, subject, pass)
    @user = user
    @pass = pass
    mail(to: @user.email, subject: subject)
  end
end
