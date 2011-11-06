require 'gol/cell'
require 'gol/universe'
require 'gol/gui/board'

require 'rspec'
require 'rspec/mocks'

RSpec::Matchers.define :have_neighbours do |expected|
  match do |actual|
    if expected.respond_to?(:each)
      actual.size.should == expected.size
      actual.cords.should == expected
    else
      cell.x.should == expected.x
      cell.y.should == expected.y
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

