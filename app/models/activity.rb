# -*- encoding : utf-8 -*-
class Activity < ActiveRecord::Base
  attr_accessible :content, :end_time, :start_time, :title, :user_id
end
