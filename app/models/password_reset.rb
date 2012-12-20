class PasswordReset < ActiveRecord::Base
  attr_accessible :token
  belongs_to :user
end
