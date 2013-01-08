class NotificationsController < ApplicationController
  before_filter :require_signin
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  def index
    @notifications = current_user.notifications
  end

  def update
    notification = Notification.find(params[:id])
    notification.update_attribute(:read, true)
    redirect_to notification.link
  end

  private
    def correct_user
      notification = Notification.find(params[:id])
      redirect_to root_path unless current_user?(notification.user)
    end
end
