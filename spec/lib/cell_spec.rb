require 'rspec_helper'

describe Cell do

  let(:board) { Board.new }

  describe 'neighbourhood' do
    it 'sholuld create cell without any neighbours' do
      cell = Cell.new(board)
      cell.neighbours.should be_empty
    end

    context 'creating two cells' do
      before :each do
        @center = Cell.new(board, 1, 1)
      end

      it 'should have one neighbour (0,0)' do
        c = Cell.new(board, 0, 0)
        @center.should have_neighbour(c)
      end
      it 'should have one neighbour (0,1)' do
        c = Cell.new(board, 0, 1)
        @center.should have_neighbour(c)
      end
      it 'should have one neighbour (0,2)' do
        c = Cell.new(board, 0, 2)
        @center.should have_neighbour(c)
      end
      it 'should have one neighbour (1,0)' do
        c = Cell.new(board, 1, 0)
        @center.should have_neighbour(c)
      end
      it 'should have one neighbour (1,2)' do
        c = Cell.new(board, 1, 2)
        @center.should have_neighbour(c)
      end
      it 'should have one neighbour (2,0)' do
        c = Cell.new(board, 2, 0)
        @center.should have_neighbour(c)
      end
      it 'should have one neighbour (2,1)' do
        c = Cell.new(board, 2, 1)
        @center.should have_neighbour(c)
      end
      it 'should have one neighbour (2,2)' do
        c = Cell.new(board, 2, 2)
        @center.should have_neighbour(c)
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

  describe 'cell live' do
    subject { Cell.new(board) }

    it 'newly created cell should be alive' do
      subject.should be_alive
    end
    it 'cell marked as dying shouldnt be alive' do
      subject.dying
      subject.should_not be_alive
    end
  end

end
