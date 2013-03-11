Given /^I am an anonymous user$/  do
  nil
end

Given /^I'm on the the "(.*?)" page$/  do |arg1|
  visit('/signup')
end

When /^I fill in signup form with the following data$/  do |table|
  values = table.hashes[0]

  fill_in('user_email', :with => values['Email'])
  fill_in('user_password', :with => values['Password'])
  fill_in('user_password_confirmation', :with => values['Confirm Password'])
  fill_in('user_first_name', :with => values['First Name'])
  fill_in('user_last_name', :with => values['Last Name'])

  click_link_or_button('Sign up')
end

Then /^I'm redirected to the welcome page$/  do
  page.current_path.should == root_path
end

Then(/^a new user should exist with email "(.*?)"$/) do |email|
  User.find_by_email(email).should_not == nil
end

Then /^I see a message saying I signed up correctly$/  do
  pending # express the regexp above with the code you wish you had
end

Then /^I see the welcome message "(.*?)"$/  do |arg1|
  pending # express the regexp above with the code you wish you had
end

