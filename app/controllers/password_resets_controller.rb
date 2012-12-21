# -*- encoding : utf-8 -*-
class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
		user.send_password_reset if user
		redirect_to root_url, :notice => "Email sent!"
	end

  def edit
		@user = PasswordReset.find_by_token!(params[:id]).user
    if @user.password_reset.created_at < 2.hours.ago
			redirect_to new_password_reset_path, :alert => "Link expired!"
    end
  end

  def update
		@user = PasswordReset.find_by_token!(params[:id]).user
    if @user.password_reset.created_at < 2.hours.ago
			redirect_to new_password_reset_path, :alert => "Link expired!"
		elsif @user.update_attributes(params[:user])
			redirect_to root_url, :notice => "success"
    else
			render :edit
		end
  end
end
