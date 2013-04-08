Feature: Create Recipe
  In order to store my recipes
  As a logged in user
  I want to create a recipe

  Scenario: Logged in user creates a new recipe
    Given a logged in user
    When the user visits the create recipe page
    And fills in the name with "New Recipe" and the tags with "dinner, personal"
    And supplies the following ingredients:
    """
    Ingredient 1
    Ingredient 2
    Ingredient 3
    Ingredient 4
    """
    And supplies the following steps:
    """
    Step 1
    Step 2
    Step 3
    Step 4
    """
    And submits the recipe to be saved
    Then a recipe: "New Recipe" should exist with name: "New Recipe"
    And the user is redirected to the "My Recipes" page
