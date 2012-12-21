# -*- encoding : utf-8 -*-
class Interest < ActiveRecord::Base
  attr_accessible :activity_id, :user_id

  belongs_to :user, class_name: "User"
  belongs_to :activity, class_name: "Activity"

  validates :user_id, presence: true
  validates :activity_id, presence: true
end
