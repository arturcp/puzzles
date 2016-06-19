class GermanCigarRule < BaseRule
  NATIONALITY = 'German'
  CIGAR = 'Prince'

  def process(matrix)
    combine(matrix, 'nationality', 'cigar')
  end

  def to_s
    'The German smokes Prince'
  end
end
