class PallMallAnimalRule < BaseRule
  CIGAR = 'Pall Mall'
  ANIMAL = 'Bird'

  def process(matrix)
    combine(matrix, 'cigar', 'animal')
  end

  def to_s
    'The person who smokes Pall Mall cigars owns a bird'
  end
end
