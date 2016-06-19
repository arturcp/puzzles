require 'byebug'
require 'colorize'
require_relative 'lib/extension'
require_relative 'lib/initial_setup'
require_relative 'lib/table'

@delay = 0

def build_initial_matrix
  Table.rows([
    ['-',           'House 1', 'House 2', 'House 3', 'House 4', 'House 5'],
    ['Wall color',  '',        '',        '',        '',         ''],
    ['Nationality', '',        '',        '',        '',         ''],
    ['Cigar',       '',        '',        '',        '',         ''],
    ['Beverage',    '',        '',        '',        '',         ''],
    ['Animal',      '',        '',        '',        '',         '']
  ])
end

def print_rules(rules)
  rules.each_with_index do |rule, index|
    puts "#{index + 1}. #{rule.to_s}"
  end
end

def remove_used_rules(rules)
  rules.reject { |rule| rule.status == :applied }
end

def apply_initial_rules(matrix, rules)
  failed_rules = []
  rules.each do |rule|
    if rule.process(matrix)
      puts "#{rule} applied".green
      rule.status = :applied
    else
      failed_rules << rule
    end
  end

  if failed_rules.length == rules.length
    matrix.show
  else
    apply_initial_rules(matrix, failed_rules)
  end
end

# Iterate on the rules and call it recursively on each candidate.
#
# After each candidate apply method call, it is possible I will need to call
# the rule's process because some of the rules can write two things in one
# row. The apply will write one of them, but the other must follow the rule
# process normally
def fill_in_matrix(matrix, rules)
  current_rules = rules.dup
  while rule = current_rules.shift
    current_candidates = rule.find_candidates(matrix)
    next if current_candidates.count == 0

    puts ''
    puts "Trying rule #{rule.to_s.yellow} with #{current_candidates.count} candidates"
    # sleep(@delay)

    index = 0

    while candidate = current_candidates.shift
      print "* [#{rule.to_s.yellow}] Candidate #{index.to_s.magenta}: #{candidate.inspect}... "
      index += 1

      current_matrix = matrix.clone
      line = candidate[:line]
      column = candidate[:column]

      candidate_content = current_matrix[line, column]
      if !candidate_content.empty? && candidate_content != candidate[:value]
        puts "#{current_matrix[line, column]} is not blank. #{"Failed".red}"
        next
      elsif candidate_content != candidate[:value] && current_matrix.column_with(content: candidate[:value], line: line)
        puts "#{candidate[:value]} is already used. #{"Failed".red}"
        next
      end

      puts 'OK'.green
      rule.apply(current_matrix, line, column, candidate[:value])

      if rule.process(current_matrix)
        # puts '___________________________________________________'
        # current_matrix.show
        # puts '___________________________________________________'

        if current_rules.empty?
          if current_matrix.complete?
            puts ''
            current_matrix.show
            puts ''
            exit 1
          end
        else
          # puts "++ Starting recursion to #{current_rules.first.to_s} ++"
          fill_in_matrix(current_matrix, current_rules)
        end
      else
        puts 'rule failed'.red
      end
    end
  end
end

def start
  matrix = build_initial_matrix
  rules = InitialSetup.rules
  matrix.show
  puts ''
  print_rules(rules)

  puts '*' * 100
  puts ''
  apply_initial_rules(matrix, rules)
  rules = remove_used_rules(rules)
  fill_in_matrix(matrix, rules)
  puts 'Solution not found'
end

start
