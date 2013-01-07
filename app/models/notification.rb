class Notification < ActiveRecord::Base
  attr_accessible :link, :read, :text, :user_id
  belongs_to :user
end
