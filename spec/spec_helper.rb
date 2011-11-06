require 'gol/cell'
require 'gol/universe'
require 'gol/gui/board'

require 'rspec'
require 'rspec/mocks'

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
  match do |universe|
    includes(universe, expected)
  end
end

private 

def includes (universe, expected)
  expected & universe.to_a == expected
end

