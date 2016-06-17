class NorwegianRule < BaseRule
  NATIONALITY = 'Norwegian'
  def process(matrix)
    if matrix[Table::NATIONALITY_LINE, Table::HOUSE_1].empty?
      matrix[Table::NATIONALITY_LINE, Table::HOUSE_1] = NATIONALITY
      true
    else
      false
    end
  end

  def to_s
    'The Norwegian lives in the first house'
  end
end
