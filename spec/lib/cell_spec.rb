require 'rspec'
require 'cell'

describe Cell do

  let(:board) { Board.new }

  describe 'state' do
    subject { Cell.new(board) }

    it 'newly created cell should be alive' do
      subject.should be_alive
    end
  end

  describe 'neighbourhood' do
    it 'sholuld create cell without any neighbours' do
      cell = Cell.new(board)
      cell.neighbours.should be_empty
    end

    context 'creating two cells' do

      before :each do
        @c0 = Cell.new(board, 1, 0)
        @c1 = Cell.new(board, 0, 1)
      end


      it 'should have one neighbour' do
        @c0.neighbours.count.should == 1
        @c1.neighbours.count.should == 1
      end

      it 'should contain neighbours' do
        @c0.neighbours[0].should == @c1
        @c1.neighbours[0].should == @c0
      end
    end
  end

  describe 'cell creation' do
    subject { Cell.new(board, 1, 2) }

    it 'should create new cell at given location x' do
      subject.x.should == 1
    end
    it 'should create new cell at given location y' do
      subject.y.should == 2
    end
    it 'cell created without any cords should have position 0,0' do
      cell = Cell.new(board)
      cell.x.should == 0
      cell.y.should == 0
    end
  end

end
