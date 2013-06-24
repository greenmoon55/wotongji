# encoding: utf-8
require 'test_helper' 

class CommentTest < ActiveSupport::TestCase
  def setup
    10.times do |i|
      user = User.new
      user.name = "user#{i+1}"
      user.email = "a#{i}@b.com"
      user.password = "11111111"
      user.password_confirmation = "11111111"
      user.save!
    end
    Category.create!(name: "default")
    3.times do |i|
      a = User.first.activities.build(title: "activity#{i}",
                                      start_time: "2013-01-01 08:00",
                                      end_time: "2013-01-01 09:00",
                                      category_id: 1,
                                      content: "saklfjdkslfjklsdfjlkdsjfsdklfjklasfjlasjfklsdjfkldsajfkdsalkfjsalkfjlskajflksdsjalfkjsasf")
      a.save!
    end
    c = Comment.new
    c.user_id = 1
    c.activity_id = 1
    c.parent_id = 1
    c.content = "testasfdfdsa"
    c.save!
  end
 
  test "001_001_001" do
    c = Comment.new
    c.user_id = ""
    c.activity_id = 1
    c.parent_id = 2
    c.content = "Test"
    assert !c.save
  end

  test "001_001_002" do
    c = Comment.new
    c.user_id = 3
    c.activity_id = ""
    c.parent_id = 1
    c.content = "Test"
    assert !c.save
  end

  test "001_001_003" do
    c = Comment.new
    c.user_id = 1
    c.activity_id = 4
    c.parent_id = 1
    c.content = ""
    assert !c.save
  end

  test "001_002_001" do
    c = Comment.new
    c.user_id = 5
    c.activity_id = 1
    c.parent_id = 1
    c.content = "Test"
    assert !c.save
  end

  test "001_003_001" do
    c = Comment.new
    c.user_id = 3
    c.activity_id = 4
    c.parent_id = 1
    c.content = "Test"
    assert !c.save
  end

  test "001_004_001" do
    c = Comment.new
    c.user_id = 1
    c.activity_id = 1
    c.parent_id = 9
    c.content = "Test"
    assert !c.save
  end 

  test "001_005_001" do
    c = Comment.new
    c.user_id = 7
    c.activity_id = 2
    c.parent_id = 1
    c.content = "Test Comment,Length>225. " * 10
    assert !c.save
  end

  test "001_006_001" do
    c = Comment.new
    c.user_id = 1
    c.activity_id = 1
    c.parent_id = nil
    c.content = "a"
    assert c.save
  end

  test "001_006_002" do
    c = Comment.new
    c.user_id = 2
    c.activity_id = 2
    c.parent_id = 1
    c.content = "aa"
    assert c.save
  end

  test "001_006_003" do
    c = Comment.new
    c.user_id = 5
    c.activity_id = 3
    c.parent_id = nil
    c.content = "Test comment,Test comment.Help!Hellow."
    assert c.save
  end

  test "001_006_004" do
    c = Comment.new
    c.user_id = 9
    c.activity_id = 1
    c.parent_id = 1
    c.content = "测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测测试测试测试测测试测试测试测饿饿饿"
    assert c.save
  end

  test "001_006_005" do
    c = Comment.new
    c.user_id = 10
    c.activity_id = 2
    c.parent_id = 1
    c.content = "测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测测试测试测试测测试测试测试测饿饿饿饿"
    assert c.save
  end


  test "002_001_001" do
    Comment.first.destroy
    assert Comment.count == 0 
  end

  test "002_002_001" do
    c = Comment.new
    c.user_id = 1
    c.activity_id = 1
    c.parent_id = 1
    c.content = "test"
    c.save!
    Comment.first.destroy
    assert Comment.count == 1
    assert Comment.last.parent_id == nil
  end

end
