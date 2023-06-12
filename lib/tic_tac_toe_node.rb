require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    # Iterate over board positions, grab position, check if it's empty
    # If empty, create node ()
    which_mark = {:x=> :o, :o=> :x} # Double check
    children = []
    @board.open_positions.each do |position|
      board_copy = @board.dup
      board_copy[position] = @next_mover_mark
      children << TicTacToeNode.new(
        board_copy, which_mark[@next_mover_mark], position)
    end
    children
  end
end
