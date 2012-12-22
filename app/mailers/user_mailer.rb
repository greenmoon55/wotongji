# -*- encoding : utf-8 -*-
class UserMailer < ActionMailer::Base
  default from: '"我同济" <hi@wotongji.com>'

  def welcome_email(user)
    @user = user
    @url = "http://wotongji.com"
    mail(:to => user.email, :subject => "欢迎注册我同济")
  end

  def password_reset(user)
		@user = user
    mail(:to => user.email, :subject => "我同济密码重置")
  end
end
