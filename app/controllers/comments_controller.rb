# -*- encoding : utf-8 -*-
class CommentsController < ApplicationController
  before_filter :require_signin

  def create
    # Do we need this extra selcect? What about a hidden field?
    # http://stackoverflow.com/questions/6480713/how-to-get-the-post-id-in-rails
    @activity = Activity.find(params[:activity_id])
    @comment = @activity.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:success] = "评论成功！"
    end
    redirect_to @activity
  end

  def destroy
  end
end
