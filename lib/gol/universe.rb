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

      @cells = []
      (0..@y).each do |y|
        row = []
        @cells << row
        (0..@x).each do |x|
          row << Cell.new(x, y)
        end
      end
    end

    def size
      [@x, @y]
    end

    def [](x, y)
      x %= @x
      y %= @y

      @cells[y][x]
    end

    def tick(callback = nil)
      callback ||= NoOpCallback.new

      toggle_cords = []

      each do |cell|
        n = neighbours(cell.x, cell.y)

        to_many_neighbours = n.count > OVERCROUDED_COUNT
        to_few_neighbours = n.count < STARVATION_COUNT
        
        toggle_cords << [cell.x, cell.y] if (to_many_neighbours || to_few_neighbours)
      end

      toggle_cords += reproduct(callback)

      toggle_cords.each do |cords|
        self.[](*cors).toggle
        # TODO
        callback.remove(cell.x, cell.y)
      end
    end

    def resurrect(x, y)
      self.[](x, y).resurrect
    end

    def each
      @cells.each do |cell_column|
        cell_column.select(&:alive?).each do |cell|
          yield(cell)
        end
      end
    end

    def remove(x, y)
      @cell[x][y].die
    end

    def empty?
      count == 0
    end

    def neighbours(x, y)
      alive = []
      neighbours_each(x, y) do |cords|
        cell = self.[](*cords)
        alive << cell if cell.alive?
      end
      alive
    end

    def dead_neighbours(x, y)
      dead = []
      neighbours_each(x, y) do |cords|
        cell = self.[](*cords)
        dead << cell unless cell.alive?
      end
      dead
    end

    def toggle(x, y)
      @cells[y][x].toggle
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
        neighbours_each(cell.x, cell.y) do |cords|
          self.[](*cords).alive?
          cell.empty_neighbours.each do |cords|
            cell_to_reproduction << cords if neighbours(*cords).count == REPRODUCTION_COUNT
          end
        end
      end
    end

  end
end
