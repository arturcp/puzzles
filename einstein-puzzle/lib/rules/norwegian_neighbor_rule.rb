class NorwegianNeighborRule < BaseRule
  NATIONALITY = 'Norwegian'
  COLOR = 'Blue'

  def process(matrix)
    neighbor(matrix, 'nationality', 'color')
  end

  def to_s
    'The Norwegian lives next to the house with blue walls'
  end
end
