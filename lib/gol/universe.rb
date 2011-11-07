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

    def [](x, y)
      x, y = normalize(x, y)
      @cells[y][x]
    end

    def []=(x, y, value)
      x, y = normalize(x, y)
      @cells[y][x] = value
    end

    def tick(callback = nil)
      callback ||= NoOpCallback.new

      toggle_cords = []

      each do |cords|
        n = neighbours(*cords)

        to_many_neighbours = n.count > OVERCROUDED_COUNT
        to_few_neighbours = n.count < STARVATION_COUNT

        toggle_cords << cords if (to_many_neighbours || to_few_neighbours)
      end

      toggle_cords += reproduct

      toggle_cords.each do |cords|
        toggle(*cords)
        callback.repaint(*cords)
      end
    end

    def resurrect(x, y)
      self.[]=(x, y, true)
    end

    def each
      (0..@y).each do |y|
        (0..@x).each do |x|
          yield([x, y]) if @cells[y][x]
        end
      end
    end

    def remove(x, y)
      self.[]=(x, y, false)
    end

    def empty?
      count == 0
    end

    def neighbours(x, y)
      alive = []
      neighbours_each(x, y) do |cords|
        alive << normalize(*cords) if self.[](*cords)
      end
      alive
    end

    def dead_neighbours(x, y)
      dead = []
      neighbours_each(x, y) do |cords|
        dead << normalize(*cords) unless self.[](*cords)
      end
      dead
    end

    def toggle(x, y)
      self.[]=(x, y, !self.[](x, y))
    end

    private

    def normalize(x, y)
      [x % @x, y % @y]
    end

    class NoOpCallback
      def repaint(x, y)
      end
    end

    def reproduct
      cell_to_reproduction = Set.new

      each do |cords|
        dead_neighbours(*cords).each do |dead_cords|
          n = neighbours(*dead_cords)
          cell_to_reproduction << normalize(*dead_cords) if n.size == REPRODUCTION_COUNT
        end
      end

      cell_to_reproduction.to_a
    end

  end
end
