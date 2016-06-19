class CharacterCombination
  attr_reader :character1, :character2, :time_to_cross

  def initialize(character1, character2)
    @character1 = character1
    @character2 = character2
    @time_to_cross = slowest(character1, character2)
  end

  def self.combine_to_cross(characters)
    size = characters.length
    result = []

    0.upto(size - 2).each do |i|
      (i + 1).upto(size - 1).each do |j|
        result << new(characters[i], characters[j])
      end
    end

    result.sort_by { |combination| combination.time_to_cross }
  end

  def self.combine_to_return(characters)
    characters.sort_by { |combination| combination.time_to_cross }.map do |char|
      new(char, nil)
    end
  end

  def to_a
    [@character1, @character2].compact
  end

  private

  def slowest(char1, char2)
    time_char2 = char2 ? char2.time_to_cross : 0
    char1.time_to_cross > time_char2 ? char1.time_to_cross : time_char2
  end
end
