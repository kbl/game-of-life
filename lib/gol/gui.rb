$: << './..'

require 'shoes'
require 'gol/cell'
require 'gol/board'


module Gol


  Shoes.app do

    stack {
      10.times do |i|
        border = i * 5
        previous_blocks = 10 * (i + 1)

        rect(width: 10, 
             left: previous_blocks + border, 
             top: 10)
      end

      
    }

    every(1) do
      clear
      @margin ||= 20

      dupa

      @margin += 20
    end

    @board = create_board

    def dupa
      rect(width: 10, 
        left: @margin, 
        top: 40)
    end

    def create_board
      board = Board.new
      Cell.new(board, 1, 1)
      Cell.new(board, 1, 2)
      Cell.new(board, 1, 3)
      board
    end
  end
end
