$: << './../..'

require 'shoes'
require 'gol/cell'
require 'gol/universe'


module Gol
  module Gui
    Shoes.app(title: 'Game of life', width: 667, height: 687) do

      @size = 10
      @margin = 3
      @universe = Universe.new(50, 50)

      click { |button, x, y|
        cord_x = (x - @size) / (@size + @margin)
        cord_y = (y - @size) / (@size + @margin)

        alert("#{cord_x} #{cord_y}")
      }


      @board = flow do
        @universe.x.times do |x|
          border_x = x * @margin
          previous_blocks_x = @size * (x + 1)

          @universe.y.times do |y|
            border_y = y * @margin
            previous_blocks_y = @size * (y + 1)

            rect(width: @size,
                 left: previous_blocks_x + border_x,
                 top: previous_blocks_y + border_y,
                 fill: rgb(240, 240, 240),
                 stroke: rgb(200, 200, 200))
          end
        end
      end
    end
  end
end

