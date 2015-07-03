require 'colorize'
require_relative 'board'
require_relative 'vector'
require_relative 'empty_square'
require_relative 'invalid_move_error'

class Piece
  attr_reader :color
  attr_accessor :board

  def initialize(color, position, board)
    @color    = color
    @king     = false
    @position = position
    @board    = board
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

  def valid_moves(&blk)
    moves = []

    displacements.each do |d|
      coord = (d.to_vector + position.to_vector).to_a

      next unless board.on_board?(*coord)

      coord = blk.call(coord)

      moves << coord if coord
    end

    moves
  end

  def slide_moves
    valid_moves { |coord| coord unless board[*coord].piece? }
  end

  def jump_moves
    valid_moves do |coord|
      next false unless board[*coord].piece?

      displacement = 2*(coord.to_vector - position.to_vector)
      coord = (displacement + position.to_vector).to_a

      next false unless board.on_board?(*coord)

      coord unless board[*coord].piece?
    end
  end

  def slide(to)
    return move!(to) if slide_moves.include?(to)

    false
  end

  def jump(to)
    return false unless jump_moves.include?(to)

    mid = ((to.to_vector + position.to_vector) / 2).to_a
    board[ *mid ] = EmptySquare::sentinel

    move!(to)
  end

  def valid_move_sequence?(sequence)
    begin
      dupped_board = board.dup
      dupped_board[*self.position].perform_moves!(sequence)
    rescue InvalidMoveError
      false
    else
      true
    end
  end

  def perform_moves(sequence)
    if valid_move_sequence?(sequence)
      perform_moves!(sequence)
    else
      raise InvalidMoveError
    end
  end

  def perform_moves!(sequence)
    if sequence.length == 1
      if slide_moves.include?(sequence[0])
        slide(sequence[0])
        return
      end
    end

    sequence.each do |move|
      if jump_moves.include?(move)
        jump(move)
      else
        raise InvalidMoveError
      end
    end
  end

  def move!(coord)
    raise "Not on board!" unless board.on_board?(*coord)
    board[*coord] = self
    board[*self.position] = EmptySquare::sentinel

    self.position = coord

    maybe_promote

    true
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

  #protected

  attr_accessor :position
end
