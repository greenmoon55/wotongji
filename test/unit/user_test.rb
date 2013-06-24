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

  test "001_005_001" do
    user = @user
    user.name = "test7"
    user.email = "a"*196 + "@b.co"
    assert !user.save
  end

  test "001_006_001" do
    user = @user.dup
    user.name = "wotongji"
    user.email = "dailin@gmail.com"
    assert user.save
    user = @user
    user.name = "tj"
    user.email = "dailin@gmail.com"
    assert !user.save
  end

  test "001_006_002" do
    user = @user.dup
    user.name = "wotongji"
    user.email = "dailin@gmail.com"
    assert user.save
    user = @user
    user.name = "tj"
    user.email = "DaiLin@gmail.com"
    assert !user.save
  end

  test "001_007_001" do
    user = User.new
    user.name = "戴琳"
    user.email = "307423@qq.com"
    user.password = "happy"
    user.password_confirmation = "happy"
    assert !user.save
  end

  test "001_008_001" do
    user = User.new
    user.name = "董金"
    user.email = "dongjin@sohu.com"
    user.password = "happyhappy"
    user.password_confirmation = "greatgreat"
    assert !user.save
  end

  test "001_009_001" do
    user = User.new
    user.name = "戴佳"
    user.email = "daijia@gmail.edu.cn"
    user.password = "dai*jia"
    user.password_confirmation = "dai*jia"
    assert user.save
  end

  test "001_009_002" do
    user = User.new
    user.name = "do#gj*n"
    user.email = "a"*196 + "@b.c"
    user.password = "dongjin"
    user.password_confirmation = "dongjin"
    assert user.save
  end

  test "001_009_003" do
    user = User.new
    user.name = "t"*30
    user.email = "dailin_307481111@qq.com"
    user.password = "戴琳戴琳戴琳戴琳戴琳"
    user.password_confirmation = "戴琳戴琳戴琳戴琳戴琳" 
    assert user.save, user.errors.messages.inspect
  end

  test "001_009_004" do
    user = User.new
    user.name = "test我同济"
    user.email = 'happy@end"se@qq.com'
    user.password = "te思d1111"
    user.password_confirmation = "te思d1111"
    assert user.save
  end

  test "002_001_001" do
    assert @user.save, "保存失败"
    assert @user.authenticate("") == false, "错误的密码"
  end

  test "002_002_001" do
    assert @user.save, "保存失败"
    assert @user.authenticate("11112222") == false, "错误的密码"
  end

  test "002_003_001" do
    assert @user.save, "保存失败"
    assert @user.authenticate("11111111"), "正确的密码"
  end

end
