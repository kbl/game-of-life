require 'spec_helper'

module Gol
  describe Cell do
    describe 'neighbourhood' do
      it 'should return array of neighbourhood cords' do
        c = Cell.new(1, 1)
        n = c.neighbours
        n.size.should == 8
        n.should == [[0, 1], [0, 2], [1, 2], [2, 2], [2, 1], [2, 0], [1, 0], [0, 0]]
      end

      context 'creating two cells' do
        before :each do
          @center = Cell.new(1, 1)
        end

        it 'should have one neighbour (0,0)' do
          c = Cell.new(0, 0)
          @center.should have_neighbours(c)
        end
        it 'should have one neighbour (0,1)' do
          c = Cell.new(0, 1)
          @center.should have_neighbours(c)
        end
        it 'should have one neighbour (0,2)' do
          c = Cell.new(0, 2)
          @center.should have_neighbours(c)
        end
        it 'should have one neighbour (1,0)' do
          c = Cell.new(1, 0)
          @center.should have_neighbours(c)
        end
        it 'should have one neighbour (1,2)' do
          c = Cell.new(1, 2)
          @center.should have_neighbours(c)
        end
        it 'should have one neighbour (2,0)' do
          c = Cell.new(2, 0)
          @center.should have_neighbours(c)
        end
        it 'should have one neighbour (2,1)' do
          c = Cell.new(2, 1)
          @center.should have_neighbours(c)
        end
        it 'should have one neighbour (2,2)' do
          c = Cell.new(2, 2)
          @center.should have_neighbours(c)
        end
      end
    end

    describe 'cell creation' do
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

    describe 'cell live' do
      subject { Cell.new }

      it 'newly created cell should be alive' do
        subject.should be_alive
      end
      it 'cell marked as dying shouldnt be alive' do
        subject.die
        subject.should_not be_alive
      end
      it 'toggle should chagne cell state' do
        subject.should be_alive
        subject.toggle
        subject.should_not be_alive
      end
    end

  end
end
