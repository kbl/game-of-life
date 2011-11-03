class Board
  attr_reader :cells

  def initialize
    @cells = []
  end

  def <<(cell)
    x = @cells[cell.x] || @cells[cell.x] = []
    x[cell.y] = cell
  end

  def [](x, y)
    @cells[x][y]
  end

end                                      
