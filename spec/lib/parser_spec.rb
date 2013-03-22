require 'spec_helper'


describe 'BlockParser' do
  let(:test_block) do
    <<-eof
        line 1
        line 2
        line 3
    eof
  end

  it 'parses each line in the provided text block' do
    lines = BlockParsers.each_line_in_block(test_block) { |line, index|  line }
    lines.length.should == 3
  end

  it 'allows you to specify a regex pattern to use as a delimiter' do
    test_string = 'string 1, string 2, string 3'
    lines = BlockParsers.each_line_in_block(test_string, /,/) { |line, index| line}
    lines.length.should == 3
  end

  it 'trims the parsed lines of all pre/post whitespace' do
    lines = BlockParsers.each_line_in_block(test_block) { |line, index|  line }
    lines.each_with_index { |line, index|
      line.should == 'line %s' % (index + 1)
    }
  end

  it 'yields the parsed line and index to the provided code block' do
    mocked_obj = double("mocked_block_obj")
    mocked_obj.should_receive(:called).exactly(3).times
    lines = BlockParsers.each_line_in_block(test_block) { |line, index|  mocked_obj.called }
  end
end

describe 'Parsers::IngredientParser' do
  let(:ingredient_block) do
    <<-eof
        ingredient 1
        ingredient 2
        ingredient 3
    eof
  end

  it 'creates an Ingredient model with each trimmed line in the block' do
    Ingredient.should_receive(:new).with(:raw_text => 'ingredient 1')
    Ingredient.should_receive(:new).with(:raw_text => 'ingredient 2')
    Ingredient.should_receive(:new).with(:raw_text => 'ingredient 3')

    BlockParsers::IngredientParser.parse_block(ingredient_block)
  end
end

describe 'Parsers::StepParser' do
  let(:step_block) do
    <<-eof
        step 1
        step 2
        step 3
    eof
  end

  it 'creates a Step model with each trimmed line in the block' do
    Step.should_receive(:new).with(:raw_text => 'step 1', :sequence => 0)
    Step.should_receive(:new).with(:raw_text => 'step 2', :sequence => 1)
    Step.should_receive(:new).with(:raw_text => 'step 3', :sequence => 2)

    steps = BlockParsers::StepParser.parse_block(step_block)
  end
end

describe 'Parsers::TagParser' do
  let(:tag_block) { 'tag 1, tag 2, tag 3' }

  it 'creates a Tag model with each token in the block' do
    Tag.should_receive(:new).with(:name => 'tag 1')
    Tag.should_receive(:new).with(:name => 'tag 2')
    Tag.should_receive(:new).with(:name => 'tag 3')

    tags = BlockParsers::TagParser.parse_block(tag_block)
  end
end