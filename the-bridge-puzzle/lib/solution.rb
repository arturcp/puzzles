class Solution
  attr_reader :time_to_cross

  def initialize(crossings)
    @crossings = crossings
    @time_to_cross = crossings.reduce(0) { |sum, crossing| sum += crossing.time_to_cross }
  end

  def print
    @crossings.each do |crossing|
      puts crossing.log
    end
  end
end
