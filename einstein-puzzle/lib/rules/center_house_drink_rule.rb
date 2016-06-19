class CenterHouseDrinkRule < BaseRule
  DRINK = 'Milk'

  def process(matrix)
    if matrix[Table::DRINK_LINE, Table::HOUSE_3].empty?
      matrix[Table::DRINK_LINE, Table::HOUSE_3] = DRINK
      true
    else
      false
    end

  end

  def to_s
    'The man living in the center house drinks milk'
  end
end
