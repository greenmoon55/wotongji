# -*- encoding : utf-8 -*-
require 'test_helper'
require 'rails/performance_test_help'

class BrowsingTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { :runs => 5, :metrics => [:wall_time, :memory]
  #                          :output => 'tmp/performance', :formats => [:flat] }

  def test_homepage
    get '/'
  end

  def test_creation
    User.create!(name: "abc", email: "sdalfjsd@adfs.com", password:"11111111", password_confirmation: "11111111")
  end
end
