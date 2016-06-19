class HorseNeighborRule < BaseRule
  ANIMAL = 'Horse'
  CIGAR = 'Dunhill'

  def process(matrix)
    neighbor(matrix, 'animal', 'cigar')
  end

  def to_s
    "The horse's owner lives next to the man who smokes Dunhill"
  end
end
