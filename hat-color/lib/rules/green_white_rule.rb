class GreenWhiteRule < BaseRule
  COLOR_1 = 'Green'
  COLOR_2 = 'White'

  def process(matrix)
    primary_column = matrix.column_with(content: COLOR_1, line: Table::COLOR_LINE)
    secondary_column = matrix.column_with(content: COLOR_2, line: Table::COLOR_LINE)

    if primary_column && primary_column < Table::HOUSE_5 && !secondary_column && matrix[Table::COLOR_LINE, primary_column + 1].empty?
      apply(matrix, Table::COLOR_LINE, primary_column + 1, COLOR_2)
      true
    elsif secondary_column && secondary_column > Table::HOUSE_1 && !primary_column && matrix[Table::COLOR_LINE, secondary_column - 1].empty?
      apply(matrix, Table::COLOR_LINE, secondary_column - 1, COLOR_1)
      true
    else
      self.candidates = find_candidates(matrix, Table::COLOR_LINE, COLOR_1, [Table::HOUSE_5])
      false
    end
  end

  def to_s
    'The house with green wall is directly to the left of the house with white walls'
  end
end
