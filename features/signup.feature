Feature: User Signup
  In Order to create recipes and menus
  As an anonymous user
  I want to signup with the Recikeep site

  Scenario: Anonymous user signs up through the signup page
    Given I am an anonymous user
    And I'm on the the "Signup" page
    When I fill in signup form with the following data
      | First Name | Last Name | Email        | Password | Confirm Password |
      | Julio      | Mistral   | foo@bar.com  | password | password         |
    Then I'm redirected to the welcome page
    And a new user should exist with email "foo@bar.com"
    # And I see a message saying I signed up correctly
    # And I see the welcome message "Welcome, Julio"