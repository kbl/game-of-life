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
          row << false
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

      toggle_cords += reproduct

      toggle_cords.each do |cords|
        toggle(*cords)
        callback.repaint(*cords)
      end
    end

    def resurrect(x, y)
      @cells[y][x] = true
    end

    def each
      (0..@y).each do |y|
        (0..@x).each do |x|
          yield([x, y]) if self.[](x, y)
        end
      end
    end

    def remove(x, y)
      @cells[y][x] = false
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
      self.[](x, y).toggle
    end

    private 

    class NoOpCallback
      def repaint(x, y)
      end
    end

    def reproduct
      cell_to_reproduction = Set.new

      each do |cell|
        dead_neighbours(*cell.cords).each do |dead_cell|
          n = neighbours(*dead_cell.cords)
          cell_to_reproduction << dead_cell.cords if n.size == REPRODUCTION_COUNT
        end
      end

      cell_to_reproduction.to_a
    end

  end
end
