
module BlockParsers
  def self.each_line_in_block(block, delim=/\n/)
    raw_lines = block.split(delim)
    models = []

    raw_lines.each_with_index do |line, index|
      model = yield line.strip, index if block_given?
      models.append(model)
    end

    return models
  end

  class IngredientParser
    def self.parse_block(block)
      return BlockParsers.each_line_in_block(block) { |line, index|
        Ingredient.new(:raw_text => line)
      }
    end
  end

  class StepParser
    def self.parse_block(block)
      return BlockParsers.each_line_in_block(block) { |line, index|
        Step.new(:raw_text => line, :sequence => index)
      }
    end
  end

  class TagParser
    extend BlockParsers

    def self.parse_block(tags)
      return BlockParsers.each_line_in_block(tags, /,/) { |tag, index|
        Tag.new(:name => tag)
      }
    end
  end
end