Given /^I am an anonymous user$/  do
  Capybara.current_session.reset!
end

When /^I fill in signup form with the following data$/  do |table|
  values = table.hashes[0]
  signup(values)
end

Then(/^I see the welcome message "(.*?)" in the navbar$/) do |welcome_message|
  within('.navbar') { page.should have_content(welcome_message) }
end

Then(/^I should see a "(.*?)" link to the "(.*?)" page in the navbar$/) do |link_text, page_name|
  within('.navbar') do
    verify_link_exists(link_text, page_name)
  end
end
