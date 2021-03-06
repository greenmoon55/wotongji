# -*- encoding : utf-8 -*-
class CommentsController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin, only: :destroy

  def create
    # Do we need this extra select? What about a hidden field?
    # http://stackoverflow.com/questions/6480713/how-to-get-the-post-id-in-rails
    #@activity = Activity.find(params[:activity_id])
    if params[:comment][:parent_id].present?
      comment = Comment.find(params[:comment][:parent_id])
      unless comment.nil?
        unless params[:comment][:content].start_with?("@" + comment.user.name)
          #params[:comment][:content].gsub!("@" + comment.user.name, 
          #  "@" + view_context.link_to(comment.user.name, comment.user))
          params[:comment].delete(:parent_id);
        else
          # rubular.com
          params[:comment][:content].gsub!(/\A@#{comment.user.name}\s*/, "")
          comment.user.build_notification(comment, current_user) unless current_user == comment.user
        end
      end
    else
      params[:comment].delete(:parent_id);
    end
    @comment = current_user.comments.build(params[:comment])
    #@comment.user = current_user
    if @comment.save
      flash[:success] = "评论成功！"
    end
    redirect_to @comment.activity
  end

  def destroy
    @comment = Comment.find(params[:id])
    activity = @comment.activity
    @comment.destroy
    flash[:success] = "删除成功"
    redirect_to activity
  end
end
