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
  has_many :intrestrelations, foreign_key: "user_id", dependent: :destroy
  has_many :intrestactivities, through: :intrestrelations, source: :activity

  #http://ruby.railstutorial.org/chapters/modeling-users#sec-format_validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {maximum: 14}, uniqueness: true;
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

  before_save { |user| user.email = email.downcase }

  def intrested_in?(intrest_activiy)
    intrestrelations.find_by_activity_id(intrest_activity.id)
  end

  def intrest_in!(intrest_activity)
    intrestrelations.create!(user_id: intrest_activity.id)
  end

  def unintrest!(intrest_activity)
    intrestrelations.find_by_activity_id(intrest_activity.id).destroy
  end
end
