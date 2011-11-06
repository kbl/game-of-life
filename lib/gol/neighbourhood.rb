module Gol
  module Neighbourhood

    # cords describing neighbours relative position
    # neighbours will be presentent allways in clockwise
    # manner
    NEIGHBOURS = [
      [-1,  0],
      [-1,  1],
      [ 0,  1],
      [ 1,  1],
      [ 1,  0],
      [ 1, -1],
      [ 0, -1],
      [-1, -1]
    ]

    def neighbours_each(cord_x = @x, cord_y = @y)
      NEIGHBOURS.each do |x, y|
        cords = [cord_x + x, cord_y + y]
        yield cords
      end
    end

  end
end
