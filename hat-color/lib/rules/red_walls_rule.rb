class RedWallsRule < BaseRule
  NATIONALITY = 'British'
  COLOR = 'Red'

  def process(matrix)
    combine(matrix, 'nationality', 'color')
  end

  def to_s
    'The Brit lives in the house with red walls'
  end
end
