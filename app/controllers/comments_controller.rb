class CommentsController < ApplicationController
  before_filter :require_signin

  def create
    @activity = Activity.find(params[:activity_id])
    @comment = @activity.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end
end