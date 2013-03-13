class Recipe < ActiveRecord::Base
  attr_accessible(:name)

  attr_accessor(:ingredient_block)
  attr_accessor(:steps_block)
  before_save :parse_blocks

  attr_accessor(:tags)
  before_save(:parse_tags)

  belongs_to(:user)

  has_many(:steps)
  has_many(:ingredients)

  has_and_belongs_to_many :tags

  def parse_blocks
    new_ingredients = BlockParsers::IngredientParser.parse_block(ingredient_block)
    new_steps = BlockParsers::StepParser.parse_block(steps_block)

    self.steps.append(new_steps)
    self.ingredients.append(new_ingredients)
  end

  def parse_tags
    new_tags = BlockParsers::TagParser.parse_block(tags)
    new_tags = new_tags.map(new_tags) { |tag| tag.user = self.user }

    self.tags.delete_all
    self.tags.append(new_tags)
  end
end
