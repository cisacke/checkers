class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def populate_grid
    [0,2,6].each do |x_coord|
      [1,3,5,7].each do |y_coord|
        self[[x_coord, y_coord]] = Piece.new(self, [x_coord, y_coord])
      end
    end

    [1,5,7].each do |x_coord|
      [0,2,4,6].each do |y_coord|
        self[[x_coord, y_coord]] = Piece.new(self, [x_coord, y_coord])
      end
    end
    nil
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  def move(start_pos, end_pos)
    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = nil
    piece.pos = end_pos
  end

  def display
    grid.each do |row|
      puts row.join(" ")
    end
    nil
  end

end

class NilClass
  def to_s
    "-"
  end
end
