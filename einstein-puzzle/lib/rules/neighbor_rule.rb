require_relative 'base_rule'

class NeighborRule < BaseRule
  def process(matrix)
    primary_line = row_index(matrix, @keys.first)
    secondary_line = row_index(matrix, @keys.last)

    column = matrix.column_with(content: primary, line: primary_line)
    secondary_column = matrix.column_with(content: secondary, line: secondary_line)

    last_column = matrix.column_count - 1

    if column && secondary_column && (column - secondary_column).abs == 1
      true
    elsif column && column == 1 && matrix[secondary_line, 2].empty? && !secondary_column
      apply(matrix, secondary_line, 2, secondary)
      true
    elsif column && column != 1 && matrix[secondary_line, column - 1].empty? && !matrix[secondary_line, column + 1] != '' && !secondary_column
      apply(matrix, secondary_line, column - 1, secondary)
      true
    elsif column && column != last_column && matrix[secondary_line, column + 1].empty? && matrix[secondary_line, column - 1] != '' && !secondary_column
      apply(matrix, secondary_line, column + 1, secondary)
      true
    else
      false
    end
  end
end
