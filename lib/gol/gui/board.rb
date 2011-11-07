require 'gol/universe'

module Gol
  module Gui
    class Board
      def initialize(universe = Universe.new(50, 50))
        @universe = universe
        @board = []
        @universe.y.times { @board << [] }
      end

      def x
        @universe.x
      end

      def y
        @universe.y
      end

      def []=(x, y, value)
        @board[x][y] = value
      end

      def [](x, y)
        @board[x][y]
      end

      def toggle(x, y)
        @universe.toggle(x, y)
        repaint(x, y)
      end

      def tick
        @universe.tick(self)
      end

      def repaint(x, y)
        rect = @board[x][y]
        if(@universe[x, y])
          rect.style(fill: rgb(0, 0, 0))
        else
          rect.style(fill: rgb(255, 255, 255))
        end
      end
    end
  end
end
