# -*- encoding : utf-8 -*-
class ActivitiesController < ApplicationController
  before_filter :require_signin, only: [:new, :create, :destroy]
  before_filter :check_user,     only: [:edit, :update, :destroy]
  before_filter :modify_params,  only: [:create, :update]

  def index
    @activities = Activity.paginate(page: params[:page])
    @categories = Category.all
    @@select_time = 'all'
    @users = User.all
  end

  def search
    if params[:q]
      @activities = Activity.where("title LIKE ?", '%' + params[:q] + '%')
      @activities = @activities.paginate(page: params[:page])
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end
    end
  end

  def all
    @activities = Activity.paginate(page: params[:page])
    @@selected_time = params[:selected]
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def upcoming
    @activities = Activity.where("start_time > ?", Time.now)
    @activities = @activities.paginate(page: params[:page])
    @@selected_time = params[:selected]
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def active
    @activities = Activity.where("start_time < ? and end_time > ?", Time.now, Time.now)
    @activities = @activities.paginate(page: params[:page])
    @@selected_time = params[:selected]
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def past
    @activities = Activity.where("end_time < ?", Time.now)
    @activities = @activities.paginate(page: params[:page])
    @@selected_time = params[:selected]
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def category
    case @@selected_time
    when 'all'
       @category = Category.find(params[:id])
       @activities = @category.activities.paginate(page: params[:page])
    when 'upcoming'
      @activities = Activity.where("start_time > ? and category_id == ?", Time.now, params[:id])
      @activities = @activities.paginate(page: params[:page])
    when 'active'
      @activities = Activity.where("start_time < ? and end_time > ? and category_id == ?",
                                   Time.now, Time.now, params[:id])
      @activities = @activities.paginate(page: params[:page])
    when 'past'
      @activities = Activity.where("end_time < ? and category_id == ?", Time.now, params[:id])
      @activities = @activities.paginate(page: params[:page])
    end
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
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
    @activity = Activity.find(params[:id])
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

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    flash[:success] = "删除成功！"
    redirect_to activities_url
  end
  
  private
    # checks if the activity belongs to current_user or current_user is an administrator
    def check_user
      unless current_user.nil?
        return if current_user.admin?
        @activity = current_user.activities.find_by_id(params[:id])
      end
      if @activity.nil?
        flash[:error] = "权限不足"
        redirect_to Activity.find(params[:id])
      end
    end
    def modify_params
      params[:activity][:start_time] += ' ' + params[:activity]["start_time(4i)"]+ ':' + params[:activity]["start_time(5i)"]
      params[:activity].delete("start_time(4i)")
      params[:activity].delete("start_time(5i)")
      params[:activity][:end_time] += ' ' + params[:activity]["end_time(4i)"] + ':' + params[:activity]["end_time(5i)"]
      params[:activity].delete("end_time(4i)")
      params[:activity].delete("end_time(5i)")
    end
end
