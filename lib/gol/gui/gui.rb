$: << './../..'

require 'shoes'
require 'gol/gui/board'

module Gol
  module Gui
    Shoes.app(title: 'Game of life', width: 667, height: 687) do
      @board = Board.new

      click { |button, x, y|
        cord_x = (x - Board::SIZE) / (Board::SIZE + Board::MARGIN)
        cord_y = (y - Board::SIZE) / (Board::SIZE + Board::MARGIN)

        @board.toggle(cord_x, cord_y)
      }

      flow do
        @board.x.times do |x|
          border_x = x * Board::MARGIN
          previous_blocks_x = Board::SIZE * (x + 1)

          @board.y.times do |y|
            border_y = y * Board::MARGIN
            previous_blocks_y = Board::SIZE * (y + 1)

            rectangle = rect(width: Board::SIZE,
                 left: previous_blocks_x + border_x,
                 top: previous_blocks_y + border_y,
                 fill: rgb(240, 240, 240),
                 stroke: rgb(200, 200, 200))
            @board[x, y] = rectangle
          end
        end
      end
      
      button 'start' do
        every(0.1) do
          @board.tick
        end
      end

      button 'krok' do
        @board.tick
      end
    end
  end
end

