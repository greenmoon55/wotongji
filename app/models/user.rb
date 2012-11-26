class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  validates :password_confirmation, presence: true
  has_secure_password
end
