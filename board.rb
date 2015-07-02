require 'colorize'
require_relative 'empty_square'

class Board
  def initialize
    @grid = Array.new(8) { |row| Array.new(8) do |col|
      (row + col).even? ? EmptySquare::black_sentinel : EmptySquare::red_sentinel
    end }
  end

  def [](arr_ish_thing)
    row, col = *arr_ish_thing
    self.grid[row][col]
  end

  def []=(arr_ish_thing, value)
    row, col = *arr_ish_thing
    self.grid[row][col] = value
  end

  def row(row_i)
    self.grid[row_i]
  end

  def render
    color = false
    self.grid.map do |row|
      color = !color
      row.map do |square|
        color = !color
        square.to_s
      end.join("  ")
    end.join("\n\n")
  end

  protected

  attr_accessor :grid
end
