# -*- encoding : utf-8 -*-
class InterestsController < ApplicationController

  def create
    @activity = Activity.find(params[:interest][:activity_id])
    current_user.interest_in!(@activity)
    respond_to do |format|
      format.html { redirect_to @activity }
      format.js
    end
  end

  def destroy
    @activity = Interest.find(params[:id]).activity
    current_user.uninterest!(@activity)
    respond_to do |format|
      format.html { redirect_to @activity }
      format.js
    end
  end
end
