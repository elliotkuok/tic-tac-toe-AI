require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    #if game is over, there are 3 scenarios: win, lose, tie
    if @board.over? 
      if @board.winner == evaluator
        return false
      elsif @board.winner != evaluator
        return true
      elsif @board.winner.nil? 
        return false
      end
    end
    #if evaluator is next this is a losing node if all children are losing nodes
    if evaluator == @next_mover_mark
      all_losing_nodes = self.children.all? do |child|
        child.losing_node?(evaluator)
      end
      no_winning_nodes = self.children.none? do |child|
        child.winning_node?(evaluator)
      end

      all_losing_nodes || no_winning_nodes
    # opponent is next; this is a losing node if 
    else
      opponent_wins = self.children.any? do |child|
        child.winning_node?(next_mover_mark)
      end
      opponent_wins
    end
  end

  def winning_node?(evaluator)#this needs to be recursive
    if @board.over?
      if @board.winner == evaluator
        return true
      elsif @board.winner != evaluator
        return false
      elsif @board.winner.nil? 
        return false
      end
    end

    if evaluator == @next_mover_mark
      next_move_win = self.children.any? do |child|
        child.winning_node?(evaluator)
      end
    else
      next_move_win = self.children.all? do |child|
        child.winning_node?(evaluator)
      end
    end
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
