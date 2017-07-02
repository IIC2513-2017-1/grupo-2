class UserMailer < ApplicationMailer

  layout "mailer"

  def welcome_email(user)
    @user = user
    @url = Rails.env.production? ? "amazingthestore.herokuapp.com/users/#{@user.confirm_token}/confirm_email" : confirm_email_user_url(@user.confirm_token, only_path: false, port: 3000)
    mail(from: 'amazing.noreply@gmail.com', to: user.email, subject: "Welcome to Amazing!")
  end

  def purchase_email(user, purchase)
    @user = user
    @purchase = purchase
    mail(from: 'amazing.noreply@gmail.com', to: user.email, subject: "Amazing purchase acknowledgement")
  end

  def admin_purchase_email(admin, user, purchase)
    @user = user
    @purchase = purchase
    @admin = admin
    @url = Rails.env.production? ? purchases_url(only_path: false) : purchases_url(only_path: false, port: 3000)
    mail(from: 'amazing.noreply@gmail.com', to: admin.email, subject: "New Amazing purchase awaits confirmation")
  end

end
