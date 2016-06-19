class DaneDrinkRule < BaseRule
  NATIONALITY = 'Dane'
  DRINK = 'Tea'

  def process(matrix)
    combine(matrix, 'nationality', 'drink')
  end

  def to_s
    'The Dane drinks tea'
  end
end
