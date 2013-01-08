# -*- encoding : utf-8 -*-
module ActivitiesHelper
  def correct_user_or_admin?
    unless current_user.nil?
      @activity.user == current_user or current_user.admin?
    else
      return false
    end
  end
end
