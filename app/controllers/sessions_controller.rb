# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = "Email或密码错误"
      #render post_signin_path
      render "new"
    end
  end
end
