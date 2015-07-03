require_relative 'board'
require_relative 'piece'

class Checkers
  attr_accessor :board

  def initialize
    @board = Board.new

    setup_board
  end

  def starting_squares
    all_coords = (0..7).to_a.product((0..7).to_a).to_a

    diagonals = all_coords.select { |(row, col)| (row + col).odd? }

    black, white = diagonals[0...12], diagonals[-12..-1]

    [black, white]
  end

  def setup_board
    black, white = starting_squares


    [[:black, black], [:white, white]].each do |(color, squares)|
      squares.each do |(row, col)|
        self.board[row, col] = Piece.new(color, [row, col], board)
      end
    end
  end
end
