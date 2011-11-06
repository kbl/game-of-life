require 'gol/cell'
require 'gol/universe'
require 'gol/gui/board'

require 'rspec'
require 'rspec/mocks'

RSpec::Matchers.define :have_neighbours do |expected|
  match do |actual|
    actual[0].should == expected
  end
end

RSpec::Matchers.define :contain do |expected|
  match do |actual|
    includes(actual, expected)
  end
end

private 

def includes (universe, expected)
  expected & universe.to_a == expected
end

