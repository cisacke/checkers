require_relative 'board'

class Piece

  attr_reader :board
  attr_accessor :pos, :color

  def initialize(board, pos)
    @color = pos[0].between?(0, 3) ? :white : :black
    @board = board
    @pos = pos
    @king = false
  end

  # def color=(color)
  #   pos[0].between?(0,3) ? :white : :black
  # end

  def [](pos)
    x, y = pos
    board.grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    board.grid[x][y] = value
  end

  def perform_slide(end_pos)
    x, y = pos
    [[forward_direction, 1], [forward_direction, -1]].each do |delta|
      check_pos = [delta[0] + x, delta[1] + y]
      if valid?(check_pos) && check_pos == end_pos && self[end_pos].nil?
        board.move(self.pos, end_pos)
        return
      end
      raise "Cannot perform this move"
    end

  end

  def perform_jump(end_pos)
    x, y = pos
    [[forward_direction + 1, 2], [forward_direction + 1, -2]].each do |delta|
      check_pos = [delta[0] + x, delta[1] + y]
      jumped_pos = [forward_direction + x, forward_direction + y]
      if valid?(check_pos) && check_pos == end_pos && self[end_pos].nil? &&
        self[jumped_pos].color != color
        puts "valid move"
      else
        puts "invalid move"
      end
    end
  end

  def forward_direction
    color == :white ? 1 : -1
  end

  def valid?(check_pos)
    check_pos.all? { |el| el.between?(0, 7)}
  end

  def to_s
    return "W" if color == :white
    return "B" if color == :black
  end


end
