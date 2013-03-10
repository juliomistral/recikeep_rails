class Step < ActiveRecord::Base
  attr_accessible :raw_text, :sequence

  belongs_to :recipe


end
