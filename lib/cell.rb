class Cell

  attr_reader :x, :y

  def initialize(x = 0, y = 0)
    @x, @y = x, y
  end

  def neighbours
    []
  end

  def alive?
    true
  end

end
