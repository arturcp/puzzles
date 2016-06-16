class CenterHouseDrinkRule < BaseRule
  def process(matrix)
    if matrix[4, 3].empty?
      matrix[4, 3] = 'Milk'
      true
    else
      false
    end

  end

  def to_s
    "The man living in the center house drinks milk"
  end
end
