puts "Creating owner..."
owner = FactoryGirl.create(:user, email: "user@example.com", password: "password")

puts "Creating event..."
event = FactoryGirl.create(:event, owner: owner)

puts "Creating users for events"
user_1 = FactoryGirl.create(:user)
user_2 = FactoryGirl.create(:user)
user_3 = FactoryGirl.create(:user)
event.users << user_1
event.users << user_2
event.users << user_3

puts "Creating invitations..."
FactoryGirl.create(:invitation, user: user_1, event: event)
FactoryGirl.create(:invitation, user: user_2, event: event)
FactoryGirl.create(:invitation, user: user_3, event: event)

puts "Creating availabilities..."
FactoryGirl.create(:availability, user: user_1, start_time: Time.zone.parse("Fri, 17 Jun 2016 12:00:00"), end_time: Time.zone.parse("Fri, 17 Jun 2016 13:00:00"))
FactoryGirl.create(:availability, user: user_1, start_time: Time.zone.parse("Fri, 17 Jun 2016 14:00:00"), end_time: Time.zone.parse("Fri, 17 Jun 2016 15:00:00"))
FactoryGirl.create(:availability, user: user_1, start_time: Time.zone.parse("Fri, 17 Jun 2016 16:00:00"), end_time: Time.zone.parse("Fri, 17 Jun 2016 17:00:00"))

FactoryGirl.create(:availability, user: user_2, start_time: Time.zone.parse("Fri, 17 Jun 2016 14:00:00"), end_time: Time.zone.parse("Fri, 17 Jun 2016 15:00:00"))
FactoryGirl.create(:availability, user: user_2, start_time: Time.zone.parse("Fri, 17 Jun 2016 16:00:00"), end_time: Time.zone.parse("Fri, 17 Jun 2016 17:00:00"))
FactoryGirl.create(:availability, user: user_2, start_time: Time.zone.parse("Fri, 17 Jun 2016 18:00:00"), end_time: Time.zone.parse("Fri, 17 Jun 2016 19:00:00"))

FactoryGirl.create(:availability, user: user_3, start_time: Time.zone.parse("Fri, 17 Jun 2016 16:00:00"), end_time: Time.zone.parse("Fri, 17 Jun 2016 17:00:00"))
FactoryGirl.create(:availability, user: user_3, start_time: Time.zone.parse("Fri, 17 Jun 2016 18:00:00"), end_time: Time.zone.parse("Fri, 17 Jun 2016 19:00:00"))
FactoryGirl.create(:availability, user: user_3, start_time: Time.zone.parse("Fri, 17 Jun 2016 20:00:00"), end_time: Time.zone.parse("Fri, 17 Jun 2016 21:00:00"))
puts "All done."
