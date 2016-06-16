class NorwegianRule < BaseRule
  def process(matrix)
    if matrix[2, 1].empty?
      matrix[2, 1] = 'Norwegian'
      true
    else
      false
    end
  end

  def to_s
    "The Norwegian lives in the first house"
  end
end
