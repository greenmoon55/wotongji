class NotificationsController < ApplicationController
  before_filter :require_signin
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  def show
    @notifications = current_user.notifications
  end

  private
    def correct_user
    end
end
