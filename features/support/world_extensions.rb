module NavigationExtensions
  PATH_MAPPINGS = {
      'Sign up' => '/signup',
      'Home' => '/',
      'Log in' => '/login',
      'My Recipes' => '/recipes',
      'New Recipe' => '/recipes/new'
  }

  def visit_page(page_name)
    page_to_visit = PATH_MAPPINGS[page_name]
    if page_to_visit != nil
      visit(page_to_visit) unless page_to_visit == nil
    else
      raise "Page '%s' doesn't have mapping setup in the testing steps" % page_name
    end

    verify_current_page_is(page_name)
  end

  def verify_current_page_is(page_name)
    page.current_path.should == PATH_MAPPINGS[page_name]
  end

  def verify_link_exists(link_text, to_page_name)
    page.should have_link(link_text, :href => PATH_MAPPINGS[to_page_name])
  end

  def verify_and_click_on(link_text)
    click_link_or_button(link_text)
  end
end
World(NavigationExtensions)

module UserExtensions
  def signup(values)
    fill_in('user_email', :with => values['Email'])
    fill_in('user_password', :with => values['Password'])
    fill_in('user_password_confirmation', :with => values['Confirm Password'])
    fill_in('user_first_name', :with => values['First Name'])
    fill_in('user_last_name', :with => values['Last Name'])

    click_link_or_button('submit_user_form')
  end

  def login
    values = {
      'Email' => 'foo@bar.com',
      'Password' => 'foobar',
      'Confirm Password' => 'foobar',
      'First Name' => 'Foo',
      'Last Name' => 'Bar',
    }
    visit_page('Sign up')
    signup(values)
  end
end
World(UserExtensions)
