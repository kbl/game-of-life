require 'spec_helper'

module Gol
  module Gui
    describe Board do
      subject { Board.new }

      let(:mock_universe) do 
        u = mock('universe')
        u.stub(:x).and_return(10)
        u.stub(:y).and_return(10)
        u
      end

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
          field = stub('field')
          field.stub(:toggle)

          board = Board.new(mock_universe)
          def board.rgb(r, g, b)
            'rgb'
          end
          board[1, 2] = field

          mock_universe.stub(:[]).and_return(Cell.new(1, 2))
          mock_universe.should_receive(:toggle).with(1, 2)
          field.should_receive(:style).with(fill: 'rgb')
          board.toggle(1, 2)
        end
        it 'should pass toggle event to field' do
          pending
          field = mock('field')
          field.should_receive(:style)

          subject[1, 2] = field

          subject.toggle(1, 2)
        end
      end
      describe 'tick for board' do
        it 'tick event should be passed to universe' do
          board = Board.new(mock_universe)
          mock_universe.should_receive(:tick)
          board.tick
        end
      end
    end
  end
end
