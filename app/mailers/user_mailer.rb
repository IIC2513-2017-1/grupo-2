class UserMailer < ApplicationMailer

  layout "mailer"

  def welcome_email(user)
    @user = user
    @url = "http://www.amazing.herokublablabla/session/new"
    mail(to: user.email, subject: "Welcome to Amazing!")
  end

  def purchase_email(user, purchase)
    @user = user
    @purchase = purchase
    mail(to: user.email, subject: "Amazing purchase acknowledgement")
  end

  def admin_purchase_email(admin, user, purchase)
    @user = user
    @purchase = purchase
    @admin = admin
    mail(to: admin.email, subject: "New Amazing purchase")
  end

end
