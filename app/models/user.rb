class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  validates :name, presence: true, length: {maximum: 1}
  validates :password_confirmation, presence: true
end
