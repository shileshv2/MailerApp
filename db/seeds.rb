# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

already_seeded_user = User.find_by_user_type("admin")
if already_seeded_user.nil?
  User.create(
    :first_name => "shilesh",
    :last_name => "kumar",
    :user_type => "admin",
    :phone_number=> "1234567890",
    :email=> "amit.kumar@in.v2solutions.com",
    :password=> "97122e182467951573b40b03abac5037d1764def4b3a3f2f575ec6abe84da966",
    :birthdate=> "2013-06-13",
    :user_name=> "admin",
    :salt => "K6FWXEMzn6A="
  )
end

already_seeded_template=TextMessageTemplate.first
if already_seeded_template.nil?
  TextMessageTemplate.create(
    :text_message_subject => "Best Wishes!",
    :text_message_body => "Hope your birthday blossoms into lots of dreams come true. Happy Birthday!!!"
  )
end