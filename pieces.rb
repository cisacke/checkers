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

  def perform_slide(end_pos)
    x, y = pos
    pos_move = nil

    deltas.each do |delta|
      check_pos = [delta[0] + x, delta[1] + y]
      pos_move = check_pos if check_pos == end_pos
    end

    return false if pos_move.nil?
    return false unless board[end_pos].nil?

    board.move(self.pos, end_pos)
    maybe_promote(end_pos)

    true
  end

  def perform_jump(end_pos)
    x, y = pos
    pos_move = nil
    jumped_pos = nil

    deltas.each do |delta|
      check_pos = [(delta[0] * 2) + x, (delta[1] * 2) + y]
      jumped_pos = [delta[0] + x, delta[1] + y] if check_pos == end_pos
      pos_move = check_pos if check_pos == end_pos
    end

    return false if pos_move.nil?
    return false unless board[end_pos].nil? && board[jumped_pos].color != color

    board.move(self.pos, end_pos)
    board[jumped_pos] = nil
    maybe_promote(end_pos)

    true
  end

  def perform_moves!(move_sequence, new_board)
    if move_sequence.length == 1
      new_board[self.pos].perform_jump(move_sequence[0])
      new_board[self.pos].perform_slide(move_sequence[0])
    else
      start_pos = self.pos
      # p "start_pos #{start_pos}"
      move_sequence.each do |move|
        # p "move #{move}"
        # p "start_pos2 #{start_pos}"
        return false unless new_board[start_pos].perform_jump(move)
        start_pos = move
        # p "start_pos3 #{start_pos}"
      end
    end

  end

  def valid_move_seq?(move_sequence)
    new_board = board.dup
    perform_moves!(move_sequence, new_board)
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
