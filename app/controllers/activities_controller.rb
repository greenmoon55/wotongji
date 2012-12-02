# -*- encoding : utf-8 -*-
class ActivitiesController < ApplicationController
  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(params[:activity])
    @activity.save
  end
end
