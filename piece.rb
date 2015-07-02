require 'colorize'
require_relative 'board'
require_relative 'vector'
require_relative 'empty_square'

class Piece
  attr_reader :color

  def initialize(color, position)
    @color    = color
    @king     = false
    @position = position
  end

  def king?
    @king
  end

  def piece?
    true
  end

  def promote
    @king = true
  end

  def displacements
    if color == :white
      [[-1, -1], [-1, 1]]
    else
      [[ 1, -1], [ 1, 1]]
    end
  end

  def available_moves(board)
    possibilities = self.displacements

    actualities = []

    possibilities.each do |displacement|
      coord = (displacement.to_vector + position.to_vector).to_a

      next unless board.on_board?(*coord)

      if !board[*coord].piece?
        actualities << coord
      elsif displacement.to_vector.magnitude < 2
        possibilities << (displacement.to_vector * 2).to_a
      end
    end

    actualities
  end

  def move!(coord, board)
    raise "Not on board!" unless board.on_board?(*coord)
    board[*coord] = self
    board[*self.position] = EmptySquare::sentinel

    self.position = coord

    maybe_promote
  end

  def maybe_promote
    row = self.position[0]

    @king ||= color == :white && row == 0
    @king ||= color == :black && row == 7
  end

  def to_s
    sigil = king? ? "\u26C3 " : "\u26C2 "
    sigil = sigil.bold

    color == :white ? sigil.cyan : sigil.red
  end

  protected

  attr_accessor :position
end
