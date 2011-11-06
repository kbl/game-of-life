require 'gol/cell'
require 'gol/universe'
require 'gol/gui/board'

require 'rspec'
require 'rspec/mocks'

RSpec::Matchers.define :have_neighbours do |expected|
  match do |actual|
    p expected
    actual[0].cords.should == expected
  end
end

RSpec::Matchers.define :contain do |expected|
  match do |actual|
    cords = actual.map { |cell| cell.cords }
    includes(cords, expected)
  end
end

private 

def includes (universe, expected)
  expected & universe.to_a == expected
end

