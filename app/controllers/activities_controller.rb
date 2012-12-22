# -*- encoding : utf-8 -*-
class ActivitiesController < ApplicationController
  before_filter :require_signin, only: [:new, :create, :destroy]
  before_filter :correct_user,   only: [:edit, :update, :destroy]

  def index
    if params[:q]
      @activities = Activity.where("title LIKE ?", '%' + params[:q] + '%')
      @activities = @activities.paginate(page: params[:page])
    else
      @activities = Activity.paginate(page: params[:page])
    end
  end

  def all
    @activities = Activity.paginate(page: params[:page])
    #respond_to do |format|
      #format.html { redirect_to @activities }
      #format.js
    #end
    render 'index'
  end

  def unstart
    @activities = Activity.where("start_time > ?", Time.now)
    @activities = @activities.paginate(page: params[:page])
    #respond_to do |format|
    #  format.html { render 'shared/activities_form' }
    #  format.js
    #end
    #render 'unstart'
  end

  def started
    @activities = Activity.where("start_time < ? and end_time > ?", Time.now, Time.now)
    @activities = @activities.paginate(page: params[:page])
    render 'started'
  end

  def ended
    @activities = Activity.where("end_time < ?", Time.now)
    @activities = @activities.paginate(page: params[:page])
    render 'ended'
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
      redirect_to @activity
    else
      flash.now[:error] = "错误"
      render 'new'
    end
  end
  
  def edit
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update_attributes(params[:activity])
      flash[:success] = "编辑成功！"
      redirect_to @activity
    else
      flash.now[:error] = "错误"
      render 'new'
    end
  end
  
  private
    def correct_user
      @activity = current_user.activities.find_by_id(params[:id])
      if @activity.nil?
        flash[:error] = "权限不足"
        redirect_to Activity.find(params[:id])
      end
    end
end
