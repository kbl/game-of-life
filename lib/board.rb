class Board

  STARVATION_COUNT = 2

  include Enumerable

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
    each do |cell|
      cell.dying if cell.neighbours.count < STARVATION_COUNT
    end
    each do |cell|
      cell.remove! if cell.dying?
    end
  end

  def each
    @cells.reject(&:nil?).each do |cell_column|
      cell_column.reject(&:nil?).each do |cell|
        yield(cell)
      end
    end
  end

  def remove(cell)
    @cells.reject(&:nil?).each do |cell_column|
      cell_column.reject(&:nil?).each do |c|
        cell_column.delete(cell) if c == cell
      end
    end
  end


  def empty?
    count == 0
  end

end
