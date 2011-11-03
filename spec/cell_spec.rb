require 'rspec'

class Cell

  def neighbours
    []
  end

end

describe Cell do
    
  it 'sholuld create cell without any neighbours' do
    cell = Cell.new
    cell.neighbours.should be_empty
  end

end
