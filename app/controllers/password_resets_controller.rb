# -*- encoding : utf-8 -*-
class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user
		  user.send_password_reset
  		redirect_to root_url, :notice => "邮件已发送"
    else
      flash[:error] = "很遗憾，没找到使用这个 Email 的用户"
      render 'new'
    end
	end

  def edit
		@user = PasswordReset.find_by_token!(params[:id]).user
    if @user.password_reset.created_at < 2.hours.ago
			redirect_to new_password_reset_path, :alert => "链接已失效"
    end
  end

  def update
		@user = PasswordReset.find_by_token!(params[:id]).user
    if @user.password_reset.created_at < 2.hours.ago
			redirect_to new_password_reset_path, :alert => "链接已失效"
		elsif @user.update_attributes(params[:user])
      @user.password_reset.destroy
			redirect_to root_url, :notice => "修改密码成功"
    else
			render :edit
		end
  end
end
