class Piece

  attr_reader :color, :board, :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @king = false
  end

  def perform_slide

  end

  def perform_jump

  end


end
