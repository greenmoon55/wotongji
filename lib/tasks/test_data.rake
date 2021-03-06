namespace :db do
  desc "Fill the database with test data"
  task populate: :environment do
    make_users
    make_activities
    make_interests
  end
end

def make_users
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "111111"
    User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password)
  end
end

def make_activities
  users = User.all(limit: 20)
  3.times do
    begin_time = Time.utc(2013, 1, 15)
    end_time = Time.utc(2013, 1, 16)
    users.each do |user|
      title = "unstart " + Faker::Name.name
      content = Faker::Lorem.sentence(15)
      user.activities.create!(title: title,
                              content: content,
                              start_time: begin_time,
                              end_time: end_time)
    end
  end
  3.times do
  begin_time = Time.utc(2012, 12, 1)
  end_time = Time.utc(2013, 1, 15)
  users.each do |user|
    title = "started " + Faker::Name.name
    content = Faker::Lorem.sentence(15)
    user.activities.create!(title: title,
                            content: content,
                            start_time: begin_time,
                            end_time: end_time)
    end
  end
  4.times do
    begin_time = Time.utc(2012, 12, 1)
    end_time = Time.utc(2012, 12, 15)
    users.each do |user|
      title = "ended " + Faker::Name.name
      content = Faker::Lorem.sentence(15)
      user.activities.create!(title: title,
                              content: content,
                              start_time: begin_time,
                              end_time: end_time)
    end
  end
end

def make_interests
  users = User.all
  interestedusers = users[2...30]
  activities = Activity.all
  interestactivities = activities[1...50]
  interestedusers.each do |user|
    interestactivities.each do |activity|
      user.interest_in!(activity)
    end
  end
end
