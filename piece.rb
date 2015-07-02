require 'colorize'
require_relative 'board'
require_relative 'vector'

class Piece
  attr_reader :color

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
    sigil = king? ? "\u26C3 " : "\u26C2 "
    sigil = sigil.bold

    color == :white ? sigil.cyan : sigil.red
  end
end
