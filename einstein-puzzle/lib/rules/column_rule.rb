require_relative 'base_rule'

class ColumnRule < BaseRule
  def process(matrix)
    primary_line = row_index(matrix, @keys.first)

    if matrix[primary_line, secondary.to_i].empty? || matrix[primary_line, secondary.to_i] == primary
      matrix[primary_line, secondary.to_i] = primary
      true
    else
      false
    end
  end

  def find_candidates(matrix)
    line = row_index(matrix, @keys.first)

    [{
      line: line,
      column: secondary.to_i,
      value: primary
    }]
  end
end
