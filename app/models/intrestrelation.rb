class Intrestrelation < ActiveRecord::Base
  attr_accessible :user_id, :activity_id

  belongs_to :user, class_name: "User"
  belongs_to :activity, class_name: "Activity"

  validates :user_id, presence: true
  validates :activity_id, presence: true
end
