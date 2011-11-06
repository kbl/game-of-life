require 'spec_helper'

module Gol
  module Gui
    describe Board do
      subject { Board.new }

      describe 'board creation' do
        it 'should be possible to create board with default size 50x50' do
          subject.x.should == 50
          subject.y.should == 50
        end
        it 'should be possible to create board with chosen size' do
          board = Board.new(Universe.new(20, 30))

          board.x.should == 20
          board.y.should == 30
        end
      end

      describe 'field toggling' do
        it 'should pass toggle event to universe' do
          universe = mock('universe')
          universe.stub(:x).and_return(10)
          universe.stub(:y).and_return(10)

          universe.should_receive(:toggle).with(1, 2)

          field = stub('field')
          field.stub(:toggle)

          board = Board.new(universe)
          board[1, 2] = field

          board.toggle(1, 2)
        end
        it 'should pass toggle event to field' do
          field = mock('field')
          field.should_receive(:toggle)

          subject[1, 2] = field

          subject.toggle(1, 2)
        end
      end
    end
  end
end
