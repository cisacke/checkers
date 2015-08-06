require_relative 'board'

class Piece

  attr_reader :color, :board, :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @king = false
  end

  def [](pos)
    x, y = pos
    board.grid[x][y]
  end

  def perform_slide(end_pos)
    x, y = pos
    [[forward_direction, 1], [forward_direction, -1]].each do |delta|
      check_pos = [delta[0] + x, delta[1] + y]
      return true if valid?(check_pos) &&
                     check_pos == end_pos &&
                     self[end_pos].nil?
    end
    false
  end

  def perform_jump(end_pos)

  end

  def forward_direction
    color == :white ? 1 : -1
  end

  def valid?(check_pos)
    check_pos.all? { |el| el.between?(0, 7)}
  end


end
