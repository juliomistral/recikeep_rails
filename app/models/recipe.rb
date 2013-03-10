class Recipe < ActiveRecord::Base
  attr_accessible(:name, :tags)

  attr_accessor(:ingredient_block)
  attr_accessor(:steps_block)

  belongs_to(:user)

  has_many(:steps)
  has_many(:ingredients)

  has_and_belongs_to_many :tags
end
