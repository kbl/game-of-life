require 'spec_helper'

module Gol
  module Gui
    describe Board do

      let(:mock_app) { mock('app') }

      let(:mock_universe) do 
        u = mock('universe')
        u.stub(:x).and_return(10)
        u.stub(:y).and_return(10)
        u
      end

      describe 'tick for board' do
        it 'tick event should be passed to universe' do
          board = Board.new(mock_app, mock_universe)
          mock_universe.should_receive(:tick)
          board.tick
        end
      end
    end
  end
end
