require_relative 'board'
require_relative 'vector'

class Piece
  def initialize(color)
    @color = color
    @king  = false
  end

  def king?
    @king
  end

  def promote
    @king = true
  end

  def to_s
    king? ? "\u26C3 " : "\u26C2 "
  end
end
