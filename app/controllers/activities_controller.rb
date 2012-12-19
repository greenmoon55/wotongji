# -*- encoding : utf-8 -*-
class ActivitiesController < ApplicationController
  before_filter :require_signin, only: [:new, :create, :destroy]
	#before_filter :correct_user,   only: [:edit, :update]

  def index
    @activities = Activity.paginate(page: params[:page])
  end

  def new
    @activity = Activity.new
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def create
    @activity = current_user.activities.build(params[:activity])
    if @activity.save
      flash[:success] = "发布成功！"
      redirect_to root_url
    else
      flash.now[:error] = "错误"
      render 'new'
    end
  end
  
  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
		if @activity.update_attributes(params[:activity])
			flash[:success] = "编辑成功！"
			redirect_to root_url
    else
      flash.now[:error] = "错误"
			render 'new'
    end
  end
end
