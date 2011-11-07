require 'gol/universe'

module Gol
  module Gui
    class Board

      FIELD_SIZE = 10
      FIELD_MARGIN = 3

      attr_reader :size, :margin

      def initialize(app, universe = Universe.new(50, 50))
        @app = app
        @universe = universe
        @board = []
        @universe.y.times { @board << [] }
      end

      def toggle(x, y)
        x_valid = (0..(@universe.x - 1)).include?(x)
        y_valid = (0..(@universe.y - 1)).include?(y)

        if(x_valid && y_valid)
          @universe.toggle(x, y)
          repaint(x, y)
        end
      end

      def tick
        @universe.tick(self)
      end

      def repaint(x, y)
        if(@universe[x, y])
          border_x = x * Board::FIELD_MARGIN
          previous_blocks_x = Board::FIELD_SIZE * (x + 1)

          border_y = y * Board::FIELD_MARGIN
          previous_blocks_y = Board::FIELD_SIZE * (y + 1)

          @board[y][x] = @app.rect(width: Board::FIELD_SIZE,
             left: previous_blocks_x + border_x,
             top: previous_blocks_y + border_y)
        else
          @board[y][x].remove
        end
      end
    end
  end
end
