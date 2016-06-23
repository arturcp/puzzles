require_relative 'base_rule'

class AttributeRule < BaseRule
  def process(matrix)
    primary_line = row_index(matrix, @keys.first)
    secondary_line = row_index(matrix, @keys.last)

    primary_column = matrix.column_with(content: primary, line: primary_line)
    secondary_column = matrix.column_with(content: secondary, line: secondary_line)

    if primary_column && secondary_column && primary_column == secondary_column
      true
    elsif primary_column && !secondary_column && matrix[secondary_line, primary_column] && matrix[secondary_line, primary_column].empty?
      apply(matrix, secondary_line, primary_column, secondary)
      true
    elsif secondary_column && !primary_column && matrix[primary_line, secondary_column] && matrix[primary_line, secondary_column].empty?
      apply(matrix, primary_line, secondary_column, primary)
      true
    else
      false
    end
  end
end
