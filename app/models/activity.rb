# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  start_time :datetime
#  end_time   :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Activity < ActiveRecord::Base
  attr_accessible :content, :end_time, :start_time, :title
  belongs_to :user

  validates :title, :content, :end_time, :start_time, :user_id, presence: true
  validates :title, length: { maximum: 50 }
  validates :content, length: { minimum: 50}

  # need to change
  validate :time_in_the_future
  validate :start_time_before_end_time
  def time_in_the_future
    if start_time <= DateTime.current
      errors.add(:alarm, "Please Choose A Future Date & Time")
    end
  end

  def start_time_before_end_time
    if start_time >= end_time
      errors.add(:alarm, "开始时间应早于结束时间")
    end
  end
end
