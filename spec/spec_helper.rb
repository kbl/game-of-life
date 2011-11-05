require 'gol/cell'
require 'gol/board'

require 'rspec'

RSpec::Matchers.define :have_neighbours do |expected|
  match do |cell|
    if expected.respond_to?(:each)
      cell.neighbours.count.should == expected.size
      includes(cell.neighbours, expected)
    else
      cell.neighbours.count.should == 1
      cell.neighbours[0].should == expected
    end
  end
end

RSpec::Matchers.define :contain do |expected|
  match do |board|
    includes(board, expected)
  end
end

def includes (board, expected)
  expected & board.to_a == expected
end
