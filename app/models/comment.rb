# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user
  belongs_to :parent_comment, class_name: :Comment, foreign_key: :parent_id
  attr_accessible :content, :activity_id, :parent_id

  validates :user_id, :activity_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
