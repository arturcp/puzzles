class YellowWallCigarRule < BaseRule
  COLOR = 'yellow'
  CIGAR = 'Dunhill'

  def process(matrix)
    if column = matrix.column_with(content: COLOR, line: Table::COLOR_LINE)
      # matrix[Table::CIGAR_LINE, column] = CIGAR
      apply(matrix, Table::CIGAR_LINE, column, CIGAR)
      true
    else
      self.candidates = candidates(matrix)
      false
    end
  end

  def to_s
    'The owner of the house with yellow walls smokes Dunhill cigars'
  end

  # All Rules must have the apply method. It is used on the `process`
  # method and also when a candidate is being applied in the matrix.
  def apply(matrix, line, column, value)
    matrix[line, column] = value
  end

  def candidates(matrix)
    list = []

    @matrix.row(line).to_a.each_with_index do |column, index|
      list << {
        line: Table::COLOR_LINE,
        column: index + 1,
        value: CIGAR
      } if column == ''
    end

    list
  end
end
