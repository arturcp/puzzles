require 'byebug'
require 'colorize'

require_relative 'lib/initial_setup'
require_relative 'lib/character_combination'
require_relative 'lib/crossing'
require_relative 'lib/solution'

LOG = false

@loading_index = 0
def print_loading
  chars = "|/-\\"
  print "\b"
  print chars[@loading_index]
  @loading_index += 1
  @loading_index = 0 if @loading_index == chars.length
end

def log(message, type = 'puts')
  return unless LOG

  if type == 'puts'
    puts message
  elsif type == 'print'
    print message
  end
end

@results = []
def make_crossing(characters_on_the_left, characters_on_the_right, crossings)
  CharacterCombination.combine_to_cross(characters_on_the_left).each do |combination|
    crossing = Crossing.new(characters_on_the_left, combination, characters_on_the_right).make

    if crossing.characters_on_the_left.length > 0
      return_crossing(crossing.characters_on_the_left, crossing.characters_on_the_right, crossings + [crossing])
    else
      @results << Solution.new(crossings + [crossing])
    end
  end
end

def return_crossing(characters_on_the_left, characters_on_the_right, crossings)
  CharacterCombination.combine_to_return(characters_on_the_right).each do |combination|
    crossing = Crossing.new(characters_on_the_left, combination, characters_on_the_right, Crossing::LEFT).make
    make_crossing(crossing.characters_on_the_left, crossing.characters_on_the_right, crossings + [crossing])
  end
end

def start
  characters = InitialSetup.characters
  make_crossing(characters, [], [])

  @results = @results.sort_by{ |result| result.time_to_cross }
  puts "#{@results.count} possible results"
  puts ''
  puts '__________________________________________________________________'
  crossing = @results.first
  puts "Best Time: #{crossing.time_to_cross}".green
  puts ''
  crossing.print
  puts ''
  puts '__________________________________________________________________'
  crossing = @results.last
  puts "Worst Time: #{crossing.time_to_cross}".red
  puts ''
  crossing.print
end

start
