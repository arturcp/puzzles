class CatNeighborRule < BaseRule
  CIGAR = 'Blend'
  ANIMAL = 'Cat'

  def process(matrix)
    neighbor(matrix, 'cigar', 'animal')
  end

  def to_s
    'The man who smokes Blends lives next to the cat owner'
  end
end
