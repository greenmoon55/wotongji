# -*- encoding : utf-8 -*-
# Send email
#config.action_mailer.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.exmail.qq.com",
  :port                 => 25,
  :user_name            => 'hi@wotongji.com',
  :password             => 'tjsse123456',
  :authentication       => 'login',
  :enable_starttls_auto => true
}
