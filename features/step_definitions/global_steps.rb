PATH_MAPPINGS = {
    'Sign up' => '/signup',
    'Home' => '/',
    'Log in' => '/login'
}

Then /^I'm redirected to the "(.*?)" page$/  do |page_name|
  page.current_path.should == PATH_MAPPINGS[page_name]
end

Given /^I'm on the the "(.*?)" page$/  do |page_name|
  page_to_visit = PATH_MAPPINGS[page_name]
  if page_to_visit != nil
    visit(page_to_visit) unless page_to_visit == nil
  else
    raise "Page '%s' doesn't have mapping setup in the testing steps" % page_name
  end
end