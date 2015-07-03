require 'colorize'
require_relative 'empty_square'

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySquare::sentinel } }
  end

  def [](*coord)
    row, col = *coord
    self.grid[row][col]
  end

  def []=(*coord, value)
    row, col = *coord
    self.grid[row][col] = value
  end

  def row(row_i)
    self.grid[row_i]
  end

  def on_board?(*coord)
    row, col = *coord
    (0...grid.length).include?(row) &&
    (0...grid[0].length).include?(col)
  end

  def dup
    double = self.class.new

    grid.each.with_index do |row, row_i|
      row.each.with_index do |piece, col_i|
        if piece.piece?
          dupped_piece = piece.dup
          double[row_i, col_i] = dupped_piece
          dupped_piece.board = double
        end
      end
    end

    double
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
