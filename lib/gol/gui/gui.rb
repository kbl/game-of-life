$: << './../..'

require 'shoes'
require 'gol/cell'
require 'gol/universe'

module Gol
  module Gui

    class Board
      def initialize
        @universe = Universe.new(50, 50)
        @board = []
        @universe.y.times { @board << [] }
      end

      def click(x, y)
        if(cell = @universe[x, y])
          cell.remove!
        else
          Cell.new(@universe, x, y)
        end
        @board[x, y].toggle
      end

      def x
        @universe.x
      end

      def y
        @universe.y
      end

      def []=(x, y, value)
        @board[x, y] = Field.new(value)
      end
      def [](x, y)
        @board[x][y]
      end
    end

    class Field
      def initialize(shape)
        @shape
      end

      def toggle
        @shape.fill('black')
      end
    end

    Shoes.app(title: 'Game of life', width: 667, height: 687) do
      @size = 10
      @margin = 3

      @board = Board.new()

      click { |button, x, y|
        cord_x = (x - @size) / (@size + @margin)
        cord_y = (y - @size) / (@size + @margin)

        alert("#{cord_x} #{cord_y}")
        alert(@board[cord_x, cord_y])
        alert(@board[cord_x, cord_y].toggle)
      }

      flow do
        @board.x.times do |x|
          border_x = x * @margin
          previous_blocks_x = @size * (x + 1)

          @board.y.times do |y|
            border_y = y * @margin
            previous_blocks_y = @size * (y + 1)

            rectangle = rect(width: @size,
                 left: previous_blocks_x + border_x,
                 top: previous_blocks_y + border_y,
                 fill: rgb(240, 240, 240),
                 stroke: rgb(200, 200, 200))
            @board[x, y] = rectangle
          end
        end
      end
    end
  end
end

