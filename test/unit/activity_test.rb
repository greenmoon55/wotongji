# encoding: utf-8
require 'test_helper' 

class ActivityTest < ActiveSupport::TestCase
  def setup
    4.times do |i|
      Category.create!(name: "category#{i}")
    end

    @activity = Activity.new
    @activity.title = "test"
    @activity.user_id = 1
    @activity.category_id = 1
    @activity.content = "本次实验包括软件项目管理、软件测试的内容，请认真完成。" * 10
  end

  def check_error
    assert_raise(NoMethodError) do 
      @activity.start_time_before_end_time
      puts "start_time: " + @activity.start_time.to_s
      puts "end_time: " + @activity.end_time.to_s 
    end
  end

  def check_success
    @activity.start_time_before_end_time
    assert @activity.errors.messages.empty?
  end

  def check_invalid
    @activity.start_time_before_end_time
    assert !@activity.errors.messages.empty?
  end
 
  test "001_001_001" do
    @activity.start_time = "2011-01-01 00:10"
    check_error
  end

  test "001_001_002" do
    @activity.start_time = "2011-01-01 10:10"
    check_error
  end

  test "001_001_003" do
    @activity.start_time = "2011-01-01 10:10"
    check_error
  end

  test "001_002_001" do
    @activity.start_time = "2001-01-01 10:12"
    @activity.end_time = "2001-01-01 10:10"
    check_invalid
  end

  test "001_002_002" do
    @activity.start_time = "2010-03-09 10:12"
    @activity.end_time = "2010-03-09 10:01"
    check_invalid
  end

  test "001_003_001" do
    @activity.start_time = "20100809 12:12"
    @activity.end_time = "2111-01-02 12:11"
    check_error
  end

  test "001_003_002" do
    @activity.start_time = "2001-09-09 12:11"
    @activity.end_time = "2009-12-   12:42"
    check_error
  end

  test "001_003_003" do
    @activity.start_time = "2001-09-09 12:11"
    @activity.end_time = "2009-ab-12 09:00"
    check_error
  end

  test "001_004_001" do
    @activity.start_time = "2000-01-32 11:01"
    @activity.end_time = "2100-01-01 12:01"
    check_error
  end

  test "001_004_002" do
    @activity.start_time = "2000-01-32 11:01"
    @activity.end_time = "2100-01-01 12:01"
    check_error
  end

  test "001_004_003" do
    @activity.start_time = "1996-01-01 01:01"
    @activity.end_time = "2012-02-31 11:01"
    check_error
  end

  test "001_004_004" do
    @activity.start_time = "1996-01-01 01:01"
    @activity.end_time = "1998-02-29 11:01"
    check_error
  end

  test "001_005_001" do
    @activity.start_time = "2000-08-08 12:30"
    @activity.end_time = "2000-08-08 13:30"
    check_success
  end

  test "001_005_002" do
    @activity.start_time = "1999-08-01 12:30"
    @activity.end_time = "1999-08-03 13:22"
    check_success
  end

  test "001_005_003" do
    @activity.start_time = "1999-10-04 12:00"
    @activity.end_time = "1999-11-01 01:11"
    check_success
  end

  test "001_005_004" do
    @activity.start_time = "2004-12-12 11:00"
    @activity.end_time = "2005-12-12 11:00"
    check_success
  end

  test "001_006_001" do
    @activity.start_time = "2001-01-01 10:10"
    @activity.end_time = "2001-01-01 10:10"
    check_invalid
  end

  test "002_001_001" do
    @activity.title = ""
    @activity.content = "a"*55
    @activity.category_id = 1
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = "2012-01-01 12:12"
    check_success
    assert !@activity.save
  end
  
  test "002_001_002" do
    @activity.title = "Hello"
    @activity.content = ""
    @activity.category_id = 1
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = "2012-01-01 12:12"
    check_success
    assert !@activity.save
  end

  test "002_001_003" do
    @activity.title = "Book"
    @activity.content = "一"*50
    @activity.category_id = nil 
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = "2012-01-01 12:12"
    check_success
    assert !@activity.save
  end
  
  test "002_001_004" do
    @activity.title = "测试"
    @activity.content = "2013年10月，大数据报告演讲。"*10
    @activity.category_id = 1 
    @activity.start_time = ""
    @activity.end_time = "2012-01-01 12:12"
    check_error
    assert !@activity.save
  end

  test "002_001_005" do
    @activity.title = "金融"
    @activity.content = "2011年11月，校运动会。"*20
    @activity.category_id = 1 
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = ""
    check_error
    assert !@activity.save
  end

  test "002_002_001" do
    @activity.title = "设计" * 50
    @activity.content = "test" * 50
    @activity.category_id = 1 
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = "2012-01-01 12:12"
    check_success
    assert !@activity.save
  end

  test "002_003_001" do
    @activity.title = "设计" * 50
    @activity.content = "test" * 50
    @activity.category_id = 1 
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = "2012-01-01 12:12"
    check_success
    assert !@activity.save
  end

  test "002_004_001" do
    @activity.title = "软件测试"
    @activity.content = "saas"
    @activity.category_id = 1 
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = "2012-01-01 12:12"
    check_success
    assert !@activity.save
  end

  test "002_005_001" do
    @activity.title = "软件项目管理"
    @activity.content = "test" * 50
    @activity.category_id = 9 
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = "2012-01-01 12:12"
    check_success
    assert !@activity.save
  end

  test "002_006_001" do
    @activity.title = "软件学院会议"
    @activity.content = "本次实验包括软件项目管理、软件测试的内容，请认真完成。" * 10
    @activity.category_id = 1
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = "2012-01-01 12:12"
    check_success
    assert @activity.save
  end

  test "002_006_002" do
    @activity.title = "书"*50
    @activity.content = "本次实验包括软件项目管理、软件测试的内容，请认真完成。" * 10
    @activity.category_id = 2 
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = "2012-01-01 12:12"
    check_success
    assert @activity.save
  end

  test "002_006_003" do
    @activity.title = "Category_book"
    @activity.content = "a" * 50
    @activity.category_id = 3
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = "2012-01-01 12:12"
    check_success
    assert @activity.save
  end

  test "002_006_004" do
    @activity.title = "Book Name Hellow Book Name Hellow Book Name Hello"
    @activity.content = "a" * 1000
    @activity.category_id = 4
    @activity.start_time = "2011-01-01 11:11"
    @activity.end_time = "2012-01-01 12:12"
    check_success
    assert @activity.save
  end
end
