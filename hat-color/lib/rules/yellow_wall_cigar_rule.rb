class YellowWallCigarRule
  COLOR = 'yellow'
  CIGAR = 'Dunhill'

  def process(matrix)
    if column = matrix.column_with(content: COLOR, line: Table::COLOR_LINE)
      matrix[Table::CIGAR_LINE, column] = CIGAR
      true
    else
      false
    end
  end

  def to_s
    "The owner of the house with yellow walls smokes Dunhill cigars"
  end
end
