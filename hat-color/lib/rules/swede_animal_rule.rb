class SwedeAnimalRule < BaseRule
  NATIONALITY = 'Swede'
  ANIMAL = 'Dog'

  def process(matrix)
    combine(matrix, 'nationality', 'animal')
  end

  def to_s
    'The Swede has a dog'
  end
end
