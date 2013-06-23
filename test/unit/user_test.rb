# encoding: utf-8
require 'test_helper' 

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new
    @user.name = "greenmoon55"
    @user.email = "a@b.com"
    @user.password = "11111111"
    @user.password_confirmation = "11111111"
  end

  test "正常保存" do
    assert @user.save
  end

  test "should not save user with no password" do
    @user.password = ""
    assert !@user.save
  end

  test "密码过短应该报错" do
    @user.password = "123"
    @user.password_confirmation = "123"
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

  test "should not save user with invalid email address1" do
    @user.email = "12345@asfjsda"
    assert !@user.save
  end

  test "should not save user with invalid email address2" do
    @user.email = "12345@asfj.@sda"
    assert !@user.save
  end

  test "should save user with valid email address" do
    @user.email = '"user@something"@example.com'
    assert @user.save
  end

  test "should save user with very very strange email address" do
    @user.email = %q{"very.(),:;<>[]\".VERY.\"very@\\ \"very\".unusual"@strange.example.com}
    assert @user.save 
  end

  test "should not save user with very long email address" do
    @user.email = "a@saklfjdsaklfjdsklfjksdljfkasdddaasdfsfddllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllsdjfklsdjfksdjfklsdjfklsdajfklsdajfklsajfklsdjfkljsdaklfjksdaljfklsdjflksdjflksdjafklsajflksdjfkljsdklfjsdakljfklsdajflksdajfklsdajjfksdjfklsdjfklsdajfklsdajfklsajfklsdjfkljsdaklfjksdaljfklsdjflksdjflksdjafklsajflksdjfkljsdklfjsdakljfklsdajflksdajfklsdajjfklsdajfklsdajfklsajfklsdjfkljsdaklfjksdaljfklsdjflksdjflksdjafklsajflksdjfkljsdklfjsdakljfklsdajflksdajfklsdajflkdsjalkfjsdalkjfklsajflksajfklsdjfklsdajfkldsjfkjsdaklfjsdklajfklasjfkldsjkfjskalfjklsdajfkldsjfklsdajfkldsjaklfjsaklfjskdajfklsajfklsdajfklsajfklasjklfdskladjfkdlsajfksaljfklsajjljsdafkljfklsdajf.com"
    assert !@user.save
  end

  test "密码1" do
    assert @user.save, "保存失败"
    assert @user.authenticate("11111111"), "正确的密码"
    assert @user.authenticate("1111111") == false, "错误的密码"
  end

end
