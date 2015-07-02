require 'colorize'
require_relative 'empty_square'

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySquare::sentinel } }
  end

  def [](arr_ish_thing)
    row, col = *arr_ish_thing
    self.grid[row][col]
  end

  def []=(arr_ish_thing, value)
    row, col = *arr_ish_thing
    self.grid[row][col] = value
  end

  def render
    color = false
    self.grid.map do |row|
      color = !color
      row.map do |square|
        color = !color
        str = square.to_s

        color ? str.on_red : str.on_black
      end.join("  ")
    end.join("\n\n")
  end

  protected

  attr_accessor :grid
end
