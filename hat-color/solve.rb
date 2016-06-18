require 'byebug'
require 'colorize'
require_relative 'lib/extension'
require_relative 'lib/initial_setup'
require_relative 'lib/table'

@result_matrix = nil
@delay = 0

def build_initial_matrix
  Table.rows([
    ['', 'House 1', 'House 2', 'House 3', 'House 4', 'House 5'],
    ['Wall color', '', '', '', '', ''],
    ['Nationality', '', '', '', '', ''],
    ['Cigar', '', '', '', '', ''],
    ['Beverage', '', '', '', '', ''],
    ['Animal', '', '', '', '', '']
  ])
end

def print_rules(rules)
  rules.each_with_index do |rule, index|
    puts "#{index + 1}. #{rule.to_s}"
  end
end

def print_matrix(matrix)
  return unless matrix

  matrix.column_count.times do |j|
    matrix.row_count.times do |i|
      print "#{matrix[j, i].rjust(20, ' ')} "
    end
    puts ''
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
    print_matrix(matrix)
  else
    apply_initial_rules(matrix, failed_rules)
  end
end

# iterate on the rules and call it recursively on each candidate.
#
# After each candidate apply method call, it is possible I will need to call
# the rule's process because some of the rules can write two things in one
# row. The apply will write one of them, but the other must follow the rule
# process normally
def fill_in_matrix(matrix, rules)
  current_rules = rules.dup
  while !@result_matrix && rule = current_rules.shift
    if rule.candidates.count == 0
      puts 'No candidates...'
      next
    end

    rule_name = rule.to_s.yellow
    puts ''
    puts "Trying rule #{rule_name} with #{rule.candidates.count} candidates"
    sleep(@delay)

    index = 0
    failure_count = 0
    current_candidates = rule.candidates.dup
    while !@result_matrix && candidate = current_candidates.shift
      print "* [#{rule.to_s.yellow}] Candidate #{index.to_s.magenta}: #{candidate.inspect}... "
      index += 1

      m = matrix.clone
      line = candidate[:line]
      column = candidate[:column]

      if m[line, column] != ''
        failure_count += 1
        print "#{m[line, column]} is not blank. #{"Failed".red}"
        puts ''
        next
      elsif m.column_with(content: candidate[:value], line: line)
        failure_count += 1
        print "#{candidate[:value]} is already used. #{"Failed".red}"
        puts ''
        next
      else
        print 'OK'.green
        puts ''
      end

      rule.apply(m, line, column, candidate[:value])

      if rule.process(m)
        # puts '___________________________________________________'
        print_matrix(m)
        # puts '___________________________________________________'

        if current_rules.empty?
          puts "EMPTY RULES".magenta
          @result_matrix = m if m.complete?
        else
          puts "++ Starting recursion to #{current_rules.first.to_s} ++"
          # debugger if  rule.to_s == 'The Dane drinks tea'
          fill_in_matrix(m, current_rules)
        end
      else
        failure_count += 1
        puts 'Process failed'.red
        sleep(@delay)
      end
    end

    if failure_count == rule.candidates.count
      puts "#{"[ABORT]".red} - All candidates failed"
    end
  end
end

def start
  matrix = build_initial_matrix
  rules = InitialSetup.rules
  print_matrix(matrix)
  puts ''
  print_rules(rules)

  puts '*' * 100
  puts ''
  apply_initial_rules(matrix, rules)
  rules = remove_used_rules(rules)
  fill_in_matrix(matrix, rules)

  puts ''
  puts ''
  puts ''
  puts ''
  puts ''
  print_matrix(@result_matrix)
  puts 'done'
end

start
