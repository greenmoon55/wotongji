# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = "Email或密码错误"
      render "new"
    end
  end

  def destroy
    sign_out
    redirect_to request.referer, :notice => "您已登出"
  end
end
