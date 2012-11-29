class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  validates :name, presence: true, length: {maximum: 14}
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

  before_save { |user| user.email = email.downcase }
end
