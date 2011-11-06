require 'gol/cell'
require 'gol/neighbourhood'
require 'set'

module Gol
  class Universe

    STARVATION_COUNT = 2
    OVERCROUDED_COUNT = 3
    REPRODUCTION_COUNT = 3

    include Enumerable
    include Neighbourhood

    attr_reader :x, :y

    def initialize(x = 100, y = 100)
      @x, @y = x, y

      @cells = Array.new(x)
      (0..x).each do |column_index|
        @cells[column_index] = Array.new(y)
      end
    end

    def size
      [@x, @y]
    end

    def <<(cell)
      cell.x %= @x
      cell.y %= @y

      column_x = @cells[cell.x]
      column_x[cell.y] = cell
    end

    def [](x, y)
      x %= @x
      y %= @y

      column_x = @cells[x]
      column_x[y]
    end

    def tick(callback = nil)
      callback ||= NoOpCallback.new

      each do |cell|
        cell.dying if cell.neighbours.count < STARVATION_COUNT
        cell.dying if cell.neighbours.count > OVERCROUDED_COUNT
      end
      reproduct(callback)
      each do |cell|
        if(cell.dying?)
          cell.remove!
          callback.remove(cell.x, cell.y)
        end
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

    def toggle(x, y)
      cell = self.[](x, y)
      if(cell)
        remove(cell)
      else
        Cell.new(self, x, y)
      end
    end

    private 

    class NoOpCallback
      def create(x, y)
      end
      def remove(x, y)
      end
    end

    def reproduct(callback)
      cell_to_reproduction = Set.new
      each do |cell|
        cell.empty_neighbours.each do |cords|
          cell_to_reproduction << cords if neighbours(*cords).count == REPRODUCTION_COUNT
        end
      end
      cell_to_reproduction.each do |cords|
        Cell.new(self, *cords)
        callback.create(*cords)
      end
    end

  end
end
