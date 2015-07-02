require 'colorize'

class EmptySquare
  def initialize(color)
    @color = color
  end

  def self.red_sentinel
    @@red ||= EmptySquare.new(:on_red)
  end

  def self.black_sentinel
    @@black ||= EmptySquare.new(:on_black)
  end

  def to_s
    @color.to_proc.call("  ")
  end
end
