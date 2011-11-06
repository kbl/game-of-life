require 'gol/universe'
require 'gol/gui/field'

module Gol
  module Gui
    class Board
      def initialize(x = 50, y = 50)
        @universe = Universe.new(x, y)
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
        @board[x][y] = Field.new(value)
      end

      def [](x, y)
        @board[x][y]
      end
    end
  end
end
