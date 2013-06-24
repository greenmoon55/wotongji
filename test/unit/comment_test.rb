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
  end
 
  test "the truth" do
    assert true
  end
end
