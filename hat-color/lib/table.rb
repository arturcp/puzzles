require 'matrix'
require 'forwardable'

class Table
  extend Forwardable

  COLOR_LINE = 1
  NATIONALITY_LINE = 2
  CIGAR_LINE = 3
  BEVERAGE_LINE = 4
  ANIMAL_LINE = 5

  def_delegators :@matrix, :row, :column_count, :row_count, :rows, :[], :[]=

  def initialize(matrix)
    @matrix = matrix
  end

  def self.rows(array)
    matrix = Matrix.rows(array)
    self.new(matrix)
  end

  def column_with(content:, line:)
    @matrix.row(line).to_a.index(content)
  end
end
