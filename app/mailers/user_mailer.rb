class UserMailer < ApplicationMailer
  layout "mailer"

  def welcome_email(user)
    @user = user
    @url = "http://www.amazing.herokublablabla/session/new"
    mail(to: user.email, subject: "Welcome to Amazing!")
  end

end
