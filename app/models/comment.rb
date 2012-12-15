class Comment < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user
  attr_accessible :content, :activity_id

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
