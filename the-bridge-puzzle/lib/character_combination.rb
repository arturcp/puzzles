class CharacterCombination
  attr_reader :character1, :character2, :time_to_cross

  def initialize(character1, character2)
    @character1 = character1
    @character2 = character2
    @time_to_cross = character1.time_to_cross + character2.time_to_cross
  end

  def self.combine(characters)
    size = characters.length
    result = []

    0.upto(size - 2).each do |i|
      (i + 1).upto(size - 1).each do |j|
        result << new(characters[i], characters[j])
      end
    end

    result.sort_by { |combination| combination.time_to_cross }.reverse
  end
end
