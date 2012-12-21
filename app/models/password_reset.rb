# -*- encoding : utf-8 -*-
class PasswordReset < ActiveRecord::Base
  attr_accessible :token
  belongs_to :user
end
