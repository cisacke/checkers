class Piece

  attr_reader :color, :board, :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @king = false
  end

  def perform_slide(end_pos)

  end

  def perform_jump(end_pos)

  end

  def forward_direction
    color == :white ? 1 : -1
  end


end
