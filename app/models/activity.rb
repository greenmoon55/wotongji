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

# -*- encoding : utf-8 -*-
class Activity < ActiveRecord::Base
  attr_accessible :content, :end_time, :start_time, :title
  belongs_to :user
end
