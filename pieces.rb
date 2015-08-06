require_relative 'board'

class Piece

  attr_reader :board
  attr_accessor :pos, :color, :king

  def initialize(board, pos, color)
    @color = color
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

  def perform_moves!(move_sequence, board_type)
    if move_sequence.length == 1
      unless (board_type[self.pos].perform_jump(move_sequence[0]) ||
      board_type[self.pos].perform_slide(move_sequence[0]))
        raise StandardError.new "This is an invalid move"
      end
    else

      @start_pos = self.pos
      move_sequence.each do |move|
        if !board_type[@start_pos].perform_jump(move)
          StandardError.new "This is an invalid move"
        end
        @start_pos = move
      end
    end
  end

  def valid_move_seq?(move_sequence)
    dup_board = board.dup
    begin
    perform_moves!(move_sequence, dup_board)
    rescue StandardError
      return false
    end
    true
  end

  def forward_direction
    color == :white ? 1 : -1
  end

  def valid?(check_pos)
    check_pos.all? { |el| el.between?(0, 7)}
  end

  def perform_moves(move_sequence, board)

    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence, board)
      true
    else
      false
    end
  end

  def maybe_promote(pos)
    @king = true if (pos[0] == 0 && color == :black)

    @king = true if (pos[0] == 7 && color == :white)
  end

  def to_s
    return "K" if king
    return "W" if color == :white
    return "B" if color == :black
  end

  def deltas
    king ? [[1,1], [1,-1], [-1,-1], [-1,1]] : [[forward_direction, 1], [forward_direction, -1]]
  end

end
