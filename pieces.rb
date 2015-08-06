require_relative 'board'

class Piece

  attr_reader :board
  attr_accessor :pos, :color, :king

  def initialize(board, pos)
    @color = pos[0].between?(0, 3) ? :white : :black
    @board = board
    @pos = pos
    @king = false
  end

  # def [](pos)
  #   x, y = pos
  #   board.grid[x][y]
  # end
  #
  # def []=(pos, value)
  #   x, y = pos
  #   board.grid[x][y] = value
  # end

  def perform_slide(end_pos)
    x, y = pos
    pos_moves = nil

    deltas.each do |delta|
      check_pos = [delta[0] + x, delta[1] + y]
      pos_moves = check_pos if check_pos == end_pos
    end

    return false if pos_moves.nil?
    return false unless board[end_pos].nil?

    board.move(self.pos, end_pos)
    maybe_promote(end_pos)

    return true
    
  end

  def perform_jump(end_pos)
    x, y = pos
    deltas.each do |delta|
      check_pos = [(delta[0] * 2) + x, (delta[1] * 2) + y]
      jumped_pos = [delta[0] + x, delta[1] + y]

      next if !valid?(check_pos) || check_pos != end_pos
      if board[end_pos].nil? && board[jumped_pos].color != color
        board.move(self.pos, end_pos)
        board[jumped_pos] = nil
        maybe_promote(end_pos)
        return
      end
    end
    false
    #raise "Cannot perform this move"
  end

  def forward_direction
    color == :white ? 1 : -1
  end

  def valid?(check_pos)
    check_pos.all? { |el| el.between?(0, 7)}
  end

  def maybe_promote(pos)
    @king = true if (pos[0] == 0 && color == :white)

    @king = true if (pos[0] == 7 && color == :black)
  end

  def to_s
    return "W" if color == :white
    return "B" if color == :black
  end

  def deltas
    [[forward_direction, 1], [forward_direction, -1]]
  end

end
