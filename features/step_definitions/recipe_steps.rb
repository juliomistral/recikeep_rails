When(/^the user visits the create recipe page$/) do
  visit_page('New Recipe')
end

When(/^fills in the name with "(.*?)" and the tags with "(.*?)"$/) do |recipe_name, tags|
  fill_in('recipe_name', :with => recipe_name)
  fill_in('recipe_tag_block', :with => tags)
end

When(/^supplies the following ingredients:$/) do |ingredient_block|
  fill_in('recipe_ingredient_block', :with => ingredient_block)
end

When(/^supplies the following steps:$/) do |step_block|
  fill_in('recipe_step_block', :with => step_block)
end

When(/^submits the recipe to be saved$/) do
  verify_and_click_on('recipe_commit')
end
