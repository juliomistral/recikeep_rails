Feature: User Signup
  In Order to create recipes and menus
  As an anonymous user
  I want to signup with the Recikeep site

  Scenario: Anonymous user visits the site
    Given I am an anonymous user
    When I'm on the "Home" page
    Then I should see a "Sign up" link to the "Sign up" page in the navbar
    And I should see a "Log in" link to the "Log in" page in the navbar

  Scenario: Anonymous user signs up through the signup page
    Given I am an anonymous user
    When I go to the "Sign up" page
    When I fill in signup form with the following data
      | First Name | Last Name | Email        | Password | Confirm Password |
      | Julio      | Mistral   | foo@bar.com  | password | password         |
    Then I'm redirected to the "Home" page
    And a user: "Julio" should exist with email: "foo@bar.com"
    And I see the welcome message "Welcome Julio" in the navbar
    # And I see a message saying I signed up correctly