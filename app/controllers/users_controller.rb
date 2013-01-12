# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :require_signin, only: [:edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
    @activities = @user.interestactivities.paginate(page: params[:page])
  end

  def my_activities
    @user = User.find(params[:id])
    @activities = @user.activities.paginate(page: params[:page])
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def interest_activities
    @user = User.find(params[:id])
    @activities = @user.interestactivities.paginate(page: params[:page])
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  # GET /users/new
  def new
    #store_previous_location
    #session[:return_to] = request.referer
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "注册成功！"
			UserMailer.welcome_email(@user).deliver
      redirect_back_or root_url
    else
      render 'new'
    end
  end

  # PUT /users/1
  def update
    #@user = User.find(params[:id])
		if @user.authenticate(params[:user][:current_password])
			params[:user].delete :current_password
			if @user.update_attributes(params[:user])
				redirect_to @user, notice: 'User was successfully updated.'
			else
				render 'edit'
			end
		else
			flash.now[:error] = "当前密码错误"
			render 'edit'
		end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end


  private
    def correct_user
			@user = User.find(params[:id])
			unless current_user?(@user)
				redirect_to root_path, notice: "Invalid operation"
      end
    end
end
