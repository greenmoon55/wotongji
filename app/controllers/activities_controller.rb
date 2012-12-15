# -*- encoding : utf-8 -*-
class ActivitiesController < ApplicationController
  before_filter :require_signin, only: [:new, :create, :destroy]

  def index
  end

  def new
    @activity = Activity.new
  end

  def show
    @activity = Activity.find(params[:id])
    if signed_in?
      @comment = Comment.new
    end
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
end
