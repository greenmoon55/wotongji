# -*- encoding : utf-8 -*-
class ActivitiesController < ApplicationController
  def new
    @activity = Activity.new
  end

  def create
    @activity = current_user.activities.build(params[:activity])
    if @activity.save
      flash[:success] = "发布成功！"
      redirect_to root_url
    else
      flash[:error] = "错误"
      redirect_to root_url
    end
  end
end
