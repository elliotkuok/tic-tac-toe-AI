require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    # Get non-losing nodes
    node = TicTacToeNode.new(game.board, mark)
    non_losing_nodes = node.children.reject do |child|
      child.losing_node?(mark)
    end
    raise RuntimeError if non_losing_nodes.empty?
    # Find winning positions
    winning_positions = []
    non_losing_nodes.each do |child|
      winning_positions << child.prev_move_pos if child.winning_node?(mark)
    end
    # If there are no winning positions, return a non-losing position
    if winning_positions.empty?
      non_losing_nodes.first.prev_move_pos
    else
      winning_positions.first
    end
  end
end

if $PROGRAM_NAME == __FILE__
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Elliot")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
