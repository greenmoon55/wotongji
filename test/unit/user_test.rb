require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new
    @user.name = "greenmoon55"
    @user.email = "a@b.com"
    @user.password = "11111111"
    @user.password_confirmation = "11111111"
  end

  test "should save normal user" do
    assert @user.save
  end

  test "should not save user with no password" do
    @user.password = ""
    assert !@user.save
  end

  test "should not save user with no password_confirmation" do
    @user.password_confirmation = ""
    assert !@user.save
  end

  test "should not save user with no email" do
    @user.email = ""
    assert !@user.save
  end

  test "should not save user with invalid email address" do
    @user.email = "12345"
    assert !@user.save
  end

  test "should not save user with invalid email address2" do
    @user.email = "12345@asfjsda"
    assert !@user.save
  end

  test "should not save user with invalid email address3" do
    @user.email = "12345@asfj.@sda"
    assert !@user.save
  end

  test "should save user with valid email address" do
    @user.email = '"user@something"@example.com'
    assert @user.save
  end
end
