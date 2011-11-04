require 'cell'
require 'rspec'

RSpec::Matchers.define :have_neighbour do |expected|
  match do |cell|
    cell.neighbours.count.should == 1
    cell.neighbours[0].should == expected
  end
end

RSpec::Matchers.define :includes do |expected|
  match do |array|
    array
    false
  end
end
