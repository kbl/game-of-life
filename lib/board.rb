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
    column_x = @cells[x]
    column_x[y] if column_x
  end
end                                      
