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
  has_many :notifications, dependent: :destroy
  has_many :interests, foreign_key: "user_id", dependent: :destroy
  has_many :interestactivities, through: :interests, source: :activity
  has_many :comments, dependent: :destroy
  has_one  :password_reset, dependent: :destroy

  #http://ruby.railstutorial.org/chapters/modeling-users#sec-format_validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {maximum: 30}, uniqueness: true;
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  def interested_in?(interest_activity)
    interests.find_by_activity_id(interest_activity.id)
  end

  #Can be inproved?
  def interest_in!(interest_activity)
    #interests.create!(self: interest_activity)
    interests.create!(activity_id: interest_activity.id)
  end

  def uninterest!(interest_activity)
    interests.find_by_activity_id(interest_activity.id).destroy
  end

  def send_password_reset
    create_password_reset!(token: SecureRandom.urlsafe_base64)
		UserMailer.password_reset(self).deliver   
  end
  
  def build_notification(comment, user)
    notifications.create!(text: "#{user.name} 回复了您对 #{comment.activity.title} 的评论", link: Rails.application.routes.url_helpers.activity_path(comment.activity), read: false)
  end

  def unread_notifications_count()
    notifications.where(read: false).count
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
