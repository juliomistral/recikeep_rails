
class Recipe < ActiveRecord::Base
  attr_accessible :name, :user, :tag_block, :ingredient_block, :step_block

  attr_accessor(:ingredient_block)
  attr_accessor(:step_block)
  attr_accessor(:tag_block)
  before_save :parse_blocks
  before_save :parse_tags

  belongs_to(:user)
  has_many(:steps)
  has_many(:ingredients)
  has_and_belongs_to_many :tags

  def parse_blocks
    new_ingredients = BlockParsers::IngredientParser.parse_block(ingredient_block)
    new_steps = BlockParsers::StepParser.parse_block(step_block)

    new_steps.each { |step| self.steps << step }
    new_ingredients.each { |ingredient| self.ingredients << ingredient }
  end

  def parse_tags
    new_tags = BlockParsers::TagParser.parse_block(tag_block)
    new_tags = new_tags.map do |tag|
      tag.user = self.user
      tag
    end

    puts 'New tags: ' + new_tags.inspect
    puts 'Existing tags: ' + self.tags.inspect
    new_tags.each { |tag| self.tags << tag }
  end

  def tag_string
    self.tags.map{ |tag| tag.name }.join(', ')
  end
end
