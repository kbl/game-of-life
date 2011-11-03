require 'board'

class Cell

  attr_reader :x, :y, :board

  def initialize(board, x = 0, y = 0)
    @x, @y = x, y
    @board = board
    board << self
  end

  def neighbours
    []
  end

  def alive?
    true
  end

end
