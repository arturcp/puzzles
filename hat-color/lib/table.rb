require 'matrix'
require 'forwardable'

class Table
  extend Forwardable

  COLOR_LINE = 1
  NATIONALITY_LINE = 2
  CIGAR_LINE = 3
  DRINK_LINE = 4
  ANIMAL_LINE = 5

  HOUSE_1 = 1
  HOUSE_2 = 2
  HOUSE_3 = 3
  HOUSE_4 = 4
  HOUSE_5 = 5

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

  def clone
    Marshal.load(Marshal.dump(self))
  end

  def complete?
    empty_items == 1
  end

  def empty_items
    empty_items = 0
    @matrix.column_count.times do |j|
      @matrix.row_count.times do |i|
        empty_items += 1 if @matrix[i, j] == ''
      end
    end

    empty_items
  end

  def show
    @matrix.column_count.times do |j|
      @matrix.row_count.times do |i|
        print "#{@matrix[j, i].rjust(20, ' ')} "
      end
      puts ''
    end
  end
end
