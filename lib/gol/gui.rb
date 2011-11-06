$: << './..'

require 'shoes'
require 'gol/cell'
require 'gol/universe'

module Gol
  Shoes.app(title: 'Game of life', width: 667, height: 667) do

    @universe = Universe.new(50, 50)

    @board = stack {
      @universe.x.times do |x|
        border_x = x * 3
        previous_blocks_x = 10 * (x + 1)

        @universe.y.times do |y|
          border_y = y * 3
          previous_blocks_y = 10 * (y + 1)

          rect(width: 10, 
               left: previous_blocks_x + border_x, 
               top: previous_blocks_y + border_y,
               fill: rgb(240, 240, 240),
               stroke: rgb(200, 200, 200))
        end
      end
    }
  end
end
