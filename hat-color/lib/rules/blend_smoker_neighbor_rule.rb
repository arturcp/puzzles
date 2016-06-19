class BlendSmokerNeighborRule < BaseRule
  CIGAR = 'Blend'
  DRINK = 'Water'

  def process(matrix)
    neighbor(matrix, 'cigar', 'drink')
  end

  def to_s
    'The man who smokes Blends has a next-door neighbor who drinks water'
  end
end
