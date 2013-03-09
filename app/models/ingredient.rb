class Ingredient < ActiveRecord::Base
  attr_accessible :raw_text

  belongs_to :recipe
end
