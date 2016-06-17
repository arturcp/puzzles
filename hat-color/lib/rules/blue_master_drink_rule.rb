class BlueMasterDrinkRule < BaseRule
  CIGAR = 'Blue Master'
  DRINK = 'Root Beer'

  def process(matrix)
    combine(matrix, 'cigar', 'drink')
  end

  def to_s
    'The man who smokes Blue Master drinks root beer'
  end
end
