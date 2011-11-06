require 'gol/universe'
require 'gol/neighbourhood'

module Gol
  class Cell

    include Neighbourhood

    attr_reader :universe
    attr_accessor :x, :y

    def initialize(universe, x = 0, y = 0)
      @x, @y = x, y
      @universe = universe
      @dying = false
      universe << self
    end

    def neighbours
      neighbours_each do |cords|
        universe[*cords]
      end
    end

    def empty_neighbours
      neighbours_each do |cords|
        cords_lower_than_zero = cords.any? { |axis| axis < 0 }

        unless(cords_lower_than_zero)
          neighbour = universe[*cords]
          cords unless neighbour
        end
      end
    end

    def alive?
      not dying?
    end

    def dying?
      @dying
    end
    
    def dying
      @dying = true
    end

    def remove!
      @universe.remove(self)
    end

    def to_s
      "Cell[#{@x}, #{y}]"
    end

  end
end
