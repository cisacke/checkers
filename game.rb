require_relative 'board.rb'

class Game

  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play

    loop do
      board.display
      start_pos, end_pos = prompt
      p start_pos
      p end_pos
      if board[start_pos].perform_slide(end_pos)

      else
        board[start_pos].perform_jump(end_pos)
      end
    end

  end

  def prompt
    puts "Enter a start position"
    start_pos = gets.chomp.split(",").map(&:to_i)
    puts "Enter an end position"
    end_pos = gets.chomp.split(",").map(&:to_i)
    [start_pos, end_pos]
  end

end
