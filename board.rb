require 'colorize'
require_relative 'empty_square'

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySquare::sentinel } }
  end

  def [](*arr_ish_thing)
    row, col = *arr_ish_thing
    self.grid[row][col]
  end

  def []=(*arr_ish_thing, value)
    row, col = *arr_ish_thing
    self.grid[row][col] = value
  end

  def row(row_i)
    self.grid[row_i]
  end

  def to_s
    color = true
    "\t\t".on_black + self.grid.map do |row|
      color = !color
      row.map do |square|
        color = !color

        str = square.to_s

        color ? str.on_black : str.on_light_black
      end.join("".on_black)
    end.join("\n\t\t".on_black)
  end

  protected

  attr_accessor :grid
end
