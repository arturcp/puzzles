require_relative 'base_rule'

class OnTheLeftRule < BaseRule
  def initialize(options = {})
    @description = options.delete(:description)
    @keys = [options[:left_attribute].keys.first] + [options[:right_attribute].keys.first]
    @primary = options[:left_attribute][@keys.first]
    @secondary = options[:right_attribute][@keys.last]
  end

  def process(matrix)
    primary_line = row_index(matrix, @keys.first)
    secondary_line = row_index(matrix, @keys.last)

    last_column = matrix.column_count - 1

    primary_column = matrix.column_with(content: primary, line: primary_line)
    secondary_column = matrix.column_with(content: secondary, line: secondary_line)

    if primary_column && primary_column < last_column && !secondary_column && matrix[secondary_line, primary_column + 1].empty?
      apply(matrix, secondary_line, primary_column + 1, secondary)
      true
    elsif secondary_column && secondary_column > 1 && !primary_column && matrix[primary, secondary_column - 1].empty?
      apply(matrix, primary_line, secondary_column - 1, primary)
      true
    else
      false
    end
  end
end
