Then /^I'm redirected to the "(.*?)" page$/  do |page_name|
  verify_current_page_is(page_name)
end

When /^I go to the "(.*?)" page$/ do |page_name|
  visit_page(page_name)
end

Given /^I'm on the "(.*?)" page$/  do |page_name|
  visit_page(page_name)
end

Given /^a logged in user$/ do
  login
end

Then /^the user is redirected to the "(.*?)" page$/ do |page_name|
  verify_current_page_is(page_name)
end

