Feature: Create Recipe
  In order to store my recipes
  As a logged in user
  I want to create a recipe

  @wip
  Scenario: Logged in user
    Given a logged in user
    When the recipe visits the create recipe page
    And fills in the new recipe form with the following data:
    | | |
    | | |
    Then the