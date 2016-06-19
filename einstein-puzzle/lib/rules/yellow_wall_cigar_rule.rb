class YellowWallCigarRule < BaseRule
  COLOR = 'Yellow'
  CIGAR = 'Dunhill'

  def process(matrix)
    combine(matrix, 'color', 'cigar')
  end

  def to_s
    'The owner of the house with yellow walls smokes Dunhill cigars'
  end
end
