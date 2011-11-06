require 'gol/neighbourhood'

module Gol
  class Cell

    include Neighbourhood

    attr_accessor :x, :y

    def initialize(x = 0, y = 0)
      @x, @y = x, y
      @alive = false
    end

    def alive?
      @alive
    end

    def die
      @alive = false
    end

    def to_s
      "Cell[#{@x}, #{y}]"
    end

    def toggle
      @alive = !@alive
    end

    def neighbours
      n = []
      neighbours_each do |cords|
        n << cords
      end
      n
    end
  end
end
