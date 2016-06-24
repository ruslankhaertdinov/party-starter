puts "Creating default user..."
FactoryGirl.create(:user, email: "user@example.com", password: "password")

puts "Creating users for event..."
user_1 = FactoryGirl.create(:user)
user_2 = FactoryGirl.create(:user)
user_3 = FactoryGirl.create(:user)

puts "Creating event..."
event = FactoryGirl.create(:event, owner: user_1)
event.users << user_1
event.users << user_2
event.users << user_3

puts "All done."
