require_relative 'base_rule'

class CenterColumnRule < BaseRule
  def process(matrix)
    primary_line = row_index(matrix, @keys.first)
    column = matrix.column_count / 2

    if matrix[primary_line, column].empty? || matrix[primary_line, column] == primary
      apply(matrix, primary_line, column, primary)
      true
    else
      false
    end
  end

  # This method is not necessary, but will remain here in case the
  # apply_initial_rules method is not call, or the code will go into an
  # infinite loop
  def find_candidates(matrix)
    line = row_index(matrix, @keys.first)
    column = matrix.column_count / 2

    [{
      line: line,
      column: column,
      value: primary
    }]
  end
end
