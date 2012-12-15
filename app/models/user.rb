# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :activities, dependent: :destroy
  has_many :interests, foreign_key: "user_id", dependent: :destroy
  has_many :interestactivities, through: :interests, source: :activity

  #http://ruby.railstutorial.org/chapters/modeling-users#sec-format_validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {maximum: 14}, uniqueness: true;
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

  before_save { |user| user.email = email.downcase }

  def interested_in?(interest_activity)
    interests.find_by_activity_id(interest_activity.id)
  end

  #Can be inproved?
  def interest_in!(interest_activity)
    #interests.create!(self: interest_activity)
    interests.create!(user_id: self.id, activity_id: interest_activity.id)
  end

  def build_interest(interest_activity)
    interests.build(user_id: self.id, activity_id: interest_activity.id)
  end

  def uninterest!(interest_activity)
    interests.find_by_activity_id(interest_activity.id).destroy
  end
end
