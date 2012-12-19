class UserMailer < ActionMailer::Base
  default from: "hi@wotongji.com"

  def welcome_email(user)
    @user = user
    @url = "http://wotongji.com"
    mail(:to => user.email, :subject => "Welcome to Wotongji!")
  end
end
