require 'rspec'

class Cell

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

end
