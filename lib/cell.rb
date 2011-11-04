require 'board'

class Cell

  attr_reader :x, :y, :board


  def initialize(board, x = 0, y = 0)
    @x, @y = x, y
    @board = board
    @dying = false
    board << self
  end

  def neighbours
    neighbours = []
    NEIGHBOURS.each do |x, y|
      neighbour = board[@x + x, @y + y]
      neighbours << neighbour if neighbour
    end
    neighbours
  end

  def empty_neighbours
    empty_neighbours = []
    NEIGHBOURS.each do |x, y|
      cords = [@x + x, @y + y]
      next if cords.any? { |axis| axis < 0 }

      neighbour = board[*cords]
      empty_neighbours << cords unless neighbour
    end
    empty_neighbours
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

  private

  # cords describing neighbours relative position
  # neighbours will be presentent allways in clockwise
  # manner
  NEIGHBOURS = [
    [-1,  0],
    [-1,  1],
    [ 0,  1],
    [ 1,  1],
    [ 1,  0],
    [ 1, -1],
    [ 0, -1],
    [-1, -1]
  ]

end
