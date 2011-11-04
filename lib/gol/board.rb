require 'gol/cell'
require 'gol/neighbourhood'
require 'set'

module Gol
  class Board

    STARVATION_COUNT = 2
    OVERCROUDED_COUNT = 3
    REPRODUCTION_COUNT = 3

    include Enumerable
    include Neighbourhood

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
        cell.dying if cell.neighbours.count > OVERCROUDED_COUNT
      end
      reproduct
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

    def neighbours(x, y)
      neighbours_each(x, y) do |cords|
        self.[](*cords)
      end
    end

    private 

    def reproduct
      cell_to_reproduction = Set.new
      each do |cell|
        cell.empty_neighbours.each do |cords|
          cell_to_reproduction << cords if neighbours(*cords).count == REPRODUCTION_COUNT
        end
      end
      cell_to_reproduction.each do |cords|
        Cell.new(self, *cords)
      end
    end

  end
end