class GreenWhiteRule < BaseRule
  COLOR_1 = 'Green'
  COLOR_2 = 'White'

  def process(matrix)
    if column = matrix.column_with(content: COLOR_1, line: Table::COLOR_LINE) && column < 5
      apply(matrix, Table::COLOR_LINE, column + 1, COLOR_2)
      true
    elsif column = matrix.column_with(content: COLOR_2, line: Table::COLOR_LINE) && column > 1
      apply(matrix, Table::COLOR_LINE, column - 1, COLOR_1)
      true
    else
      self.candidates = candidates(matrix, Table::COLOR_LINE, COLOR_1)
      false
    end
  end

  def to_s
    'The house with green wall is directly to the left of the house with white walls'
  end
end
