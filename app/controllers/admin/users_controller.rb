# -*- encoding : utf-8 -*-
class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end
end
