require 'rspec'
require 'board'

describe Board do

  subject { Board.new }

  it 'shouldnt have any cells' do 
    subject.cells.should be_empty
  end

  it 'should remember created cells' do
    subject << Cell.new
    subject << Cell.new(1, 3)

    subject.cells.count.should == 2
  end

end
