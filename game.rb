require_relative 'board.rb'

class Game

  attr_accessor :board, :current_player

  def initialize
    @board = Board.new
    @player1 = :white
    @player2 = :black
    @current_player = :white
  end

  def play

    board.populate_grid
    board.display

    until won?
      board.display
      puts "#{current_player} - please make a move"

      begin
        @start_pos = prompt_start
        move_sequence = prompt_end
      rescue StandardError => e
        puts e
        retry
      end

      board[@start_pos].perform_moves(move_sequence, board)

      current_player == :white ? @current_player = :black : @current_player = :white

    end
    puts "The winner is #{current_player}"
  end

  def won?
    board.pieces.nil?
  end

  def prompt_start
    puts "Enter a start position (i,j)"
    @start_pos = gets.chomp.split(",").map(&:to_i)
    if board[@start_pos].nil?
      raise StandardError.new "There is no piece in this position"
    elsif board[@start_pos].color != current_player
      raise StandardError.new "You cannot move you opponent's piece"
    end
    @start_pos
  end

  def prompt_end
    puts "Enter an end position (i,j) or move sequence (i,j a,b x,y)"
    move_sequence = gets.chomp.split(" ").map do |input|
      input.split(",").map(&:to_i)
    end

    unless board[@start_pos].valid_move_seq?(move_sequence)
      raise StandardError.new "This is an invalid move"
    end

    move_sequence
  end

end
