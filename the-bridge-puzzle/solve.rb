require 'byebug'
require 'colorize'

require_relative 'lib/initial_setup'
require_relative 'lib/character_combination'

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

def print_combinations(combinations)
  combinations.each do |combination|
    puts "#{combination.character1.name} - #{combination.character2.name}"
  end
end

def start
  characters = InitialSetup.characters
  combinations = CharacterCombination.combine(characters)
  print_combinations(combinations)
end

start
