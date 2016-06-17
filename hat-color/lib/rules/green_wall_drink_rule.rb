class GreenWallDrinkRule < BaseRule
  COLOR = 'Green'
  DRINK = 'Coffee'

  def process(matrix)
    combine(matrix, 'color', 'drink')
  end

  def to_s
    'The owner of the house with green walls drinks coffee'
  end
end
