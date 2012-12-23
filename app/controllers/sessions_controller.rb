# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:remember_token] = user.remember_token
      else
        session[:current_user_id] = user.id
      end
      self.current_user = user
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
