class InterestsController < ApplicationController
  def create
    @activity = Activity.find(params[:interest][:activity_id])
    current_user.interest_in!(@activity)
    redirect_to @activity
  end

  def destroy
    @activity = Activity.find(params[:activity_id])
    current_user.uninterest!(@activity)
    redirect_to @activity
  end
end
