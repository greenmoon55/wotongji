class InterestsController < ApplicationController

  def create
    @activity = Activity.find(params[:interest][:activity_id])
    current_user.interest_in!(@activity)
    #@interest = Interest.new(params[:interest])
    #@interest.save
    flash[:success]='success'
    redirect_to current_user
  end

  def destroy
    
  end
end
