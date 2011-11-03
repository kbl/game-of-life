require 'rspec'
require 'board'

describe Board do

  it 'shouldnt have any cells' do 
    Board.new.cells.should be_empty
  end

end
