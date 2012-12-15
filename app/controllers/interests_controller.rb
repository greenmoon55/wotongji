class InterestsController < ApplicationController

  def create
    #@activity = Activity.find(params[:activity_id])
    #current_user.interest_in!(@activity)
    @interest = Interest.new(params[:interest])
    @interest.save
    redirect_to current_user
  end

  def destroy
    
  end
end
