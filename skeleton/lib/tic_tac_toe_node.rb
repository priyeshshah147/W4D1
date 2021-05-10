require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if self.board.over? 
      if board.winner == evaluator && self.board.won?
        return false
      else
        return true
      end

    end
    if evaluator == self.next_mover_mark
      self.children.all?{|child| child.losing_node?(evaluator)}
    else
      self.children.any?{|child| child.losing_node?(evaluator)}
    end

  end

  def winning_node?(evaluator)
    if board.winner == evaluator || self.children.next_mover_mark 
      return true
    else
      return false
    end

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    res = []
    board.rows.each_with_index do |row, i1|
      row.each_with_index do |col, i2|
        if col == nil
          new_mark = :o
          new_mark = :x if next_mover_mark == :o
          fake_board = board.dup
          fake_board.rows[i1][i2] = new_mark
          res << TicTacToeNode.new(fake_board, new_mark, [i1, i2])
        end
      end
    end
    res
  end
  
 


  

end

# # first1 = TicTacToeNode.new(fake_board, new_mark, [i1, i2])
# .losing_node?


