require 'gol/universe'
require 'gol/neighbourhood'

module Gol
  class Cell

    attr_accessor :x, :y

    def initialize(x = 0, y = 0)
      @x, @y = x, y
      @alive = true
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

  end
end
