class Notification < ActiveRecord::Base
  attr_accessible :link, :read, :text, :user_id
end
