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
        @board[x][y].toggle
      end

      def tick
        @universe.tick
      end
    end
  end
end
