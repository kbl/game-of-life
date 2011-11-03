class Board
  attr_reader :cells

  def initialize
    @cells = []
  end

  def <<(cell)
    column_x = @cells[cell.x] || @cells[cell.x] = []
    column_x[cell.y] = cell
  end

  def [](x, y)
    return if x < 0 || y < 0

    column_x = @cells[x]
    column_x[y] if column_x
  end

  def tick
    @cells.each do |cell_column|
      cell_column.each do |cell|
        cell.dying if cell.neighbours > 3
      end
    end
    @cells.each do |cell_column|
      cell_column.each do |cell|
        cell_column.delete(cell) if cell.dying?
      end
    end
  end

end
