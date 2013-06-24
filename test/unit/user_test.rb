# encoding: utf-8
require 'test_helper' 

class UserTest < ActiveSupport::TestCase
  def setup
    # 正常的user
    @user = User.new
    @user.name = "greenmoon55"
    @user.email = "a@b.com"
    @user.password = "11111111"
    @user.password_confirmation = "11111111"
  end

  test "001_001_001" do
    user = @user
    user.name = ""
    user.email = "M1@qq.com"
    assert !user.save
  end

  test "001_001_002" do
    user = @user
    user.email = ""
    user.name = "测试1"
    assert !user.save
  end

  test "001_001_003" do
    user = @user
    user.name = "测试2"
    user.email = "M2@sohu.com"
    user.password = ""
    assert !user.save
  end

  test "001_001_004" do
    user = @user
    user.name = "测试3"
    user.email = "M3@sina.com"
    user.password_confirmation = ""
    assert !user.save
  end

  test "001_002_001" do
    user = @user
    user.name = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1"
    user.email = "M4@tongji.com"
    user.password = "ff"
    user.password_confirmation = "ff"
    assert !user.save
  end

  test "001_003_001" do
    @user.name = "我同济"
    assert @user.save
    user = User.new
    user.name = "我同济"
    user.email = "m5@fudan.edu.cn"
    user.password = "11111111"
    user.password_confirmation = "11111111"
    assert !user.save
  end

  test "001_004_001" do
    user = @user
    user.name = "测试4"
    user.email = "dailin@gmail"
    assert !user.save
  end
  
  test "001_004_002" do
    user = @user
    user.name = "测试5"
    user.email = "gmail.com"
    assert !user.save
  end

  test "001_004_003" do
    user = @user
    user.name = "test6"
    user.email = "dailin@gmail"
    assert !user.save
  end

  test "密码1" do
    assert @user.save, "保存失败"
    assert @user.authenticate("11111111"), "正确的密码"
    assert @user.authenticate("1111111") == false, "错误的密码"
  end

end
