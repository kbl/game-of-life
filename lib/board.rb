class Board
  attr_reader :cells

  def initialize
    @cells = []
  end

  def <<(cell)
    @cells << cell
  end

end
