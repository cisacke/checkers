require_relative 'pieces'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def populate_grid
    [0,2].each do |x_coord|
      [1,3,5,7].each do |y_coord|
        self[[x_coord, y_coord]] = Piece.new(self, [x_coord, y_coord], :white)
      end
    end

    [0,2,4,6].each do |y_coord|
      self[[1, y_coord]] = Piece.new(self, [1, y_coord], :white)
    end

    [1,3,5,7].each do |y_coord|
      self[[6, y_coord]] = Piece.new(self, [6, y_coord], :black)
    end


    [5,7].each do |x_coord|
      [0,2,4,6].each do |y_coord|
        self[[x_coord, y_coord]] = Piece.new(self, [x_coord, y_coord], :black)
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
    puts "  0 1 2 3 4 5 6 7"
    grid.each_with_index do |row, idx|
      puts idx.to_s + " " + row.join(" ")
    end
    nil
  end

  def pieces
    grid.flatten.compact
  end

  def dup
    new_board = Board.new

    pieces.each do |piece|
      new_board[piece.pos] = Piece.new(new_board, piece.pos, piece.color)
    end

    new_board
  end

end

class NilClass
  def to_s
    "-"
  end
end
