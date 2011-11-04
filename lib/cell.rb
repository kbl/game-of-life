require 'board'
require 'neighbourhood'

class Cell

  include ::Neighbourhood

  attr_reader :x, :y, :board

  def initialize(board, x = 0, y = 0)
    @x, @y = x, y
    @board = board
    @dying = false
    board << self
  end

  def neighbours
    neighbours_each do |cords|
      board[*cords]
    end
  end

  def empty_neighbours
    neighbours_each do |cords|
      cords_lower_than_zero = cords.any? { |axis| axis < 0 }

      unless(cords_lower_than_zero)
        neighbour = board[*cords]
        cords unless neighbour
      end
    end
  end

  def neighbours_each(cord_x = @x, cord_y = @y)
    neighbours = []
    NEIGHBOURS.each do |x, y|
      cords = [cord_x + x, cord_y + y]

      returned = yield cords

      neighbours << returned if returned
    end
    neighbours
  end


  def alive?
    not dying?
  end
  def dying?
    @dying
  end
  def dying
    @dying = true
  end

  def remove!
    @board.remove(self)
  end

  def to_s
    "Cell[#{@x}, #{y}]"
  end

end
