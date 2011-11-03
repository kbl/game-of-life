require 'rspec'

class Cell

  attr_reader :x, :y

  def initialize(x = 0, y = 0)
    @x, @y = x, y
  end

  def neighbours
    []
  end

  def alive?
    true
  end

end

describe Cell do

  describe 'state' do
    subject { Cell.new }

    it 'newly created cell should be alive' do
      subject.should be_alive
    end

  end
    
  it 'sholuld create cell without any neighbours' do
    cell = Cell.new
    cell.neighbours.should be_empty
  end

  describe 'cell spawning' do

    subject { Cell.new(1, 2) }

    it 'should create new cell at given location x' do
      subject.x.should == 1
    end

    it 'should create new cell at given location y' do
      subject.y.should == 2
    end

    it 'cell created without any cords should have position 0,0' do
      cell = Cell.new
      cell.x.should == 0
      cell.y.should == 0
    end
  end

end
