require 'rspec'
require 'board'
require 'cell'

describe Board do

  subject { Board.new }

  describe 'board creation' do
    it 'shouldnt have any cells' do 
      subject.cells.should be_empty
    end
    it 'should remember created cells' do
      Cell.new(subject)
      Cell.new(subject, 1, 3)

      subject.cells.count.should == 2
    end
  end

  describe 'cell access' do
    it 'should have access to cell at specified cords' do 
      cell = Cell.new(subject)
      subject[0, 0].should == cell
    end
    it 'should return nil for unknown cell' do
      subject[123, 12].should be_nil
    end
  end

end