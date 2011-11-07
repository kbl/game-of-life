$: << './../..'

require 'shoes'
require 'gol/gui/board'

module Gol
  module Gui
    Shoes.app(title: 'Game of life', width: 667, height: 707) do
      @board = Board.new(self)

      click { |button, x, y|
        cord_x = (x - Board::FIELD_SIZE) / (Board::FIELD_SIZE + Board::FIELD_MARGIN)
        cord_y = (y - Board::FIELD_SIZE) / (Board::FIELD_SIZE + Board::FIELD_MARGIN)

        @board.toggle(cord_x, cord_y)
      }

      flow top: 670, left: 7 do
        button 'start' do
          @loop = every(0.1) do
            @board.tick
          end
        end
        button 'stop' do
          @loop.stop
        end
        button 'step' do
          @board.tick
        end
      end
    end
  end
end

