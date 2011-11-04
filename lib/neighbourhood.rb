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
    neighbours = []
    NEIGHBOURS.each do |x, y|
      cords = [cord_x + x, cord_y + y]

      returned = yield cords

      neighbours << returned if returned
    end
    neighbours
  end

end
