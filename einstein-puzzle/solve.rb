require 'byebug'
require 'colorize'
require_relative 'lib/extension'
require_relative 'lib/initial_setup'
require_relative 'lib/table'
require_relative '../logger'

@logger = Logger.new(false)

LAST_CELL_CONTENT = 'FISH'

@loading_index = 0
def print_loading
  chars = "|/-\\"
  print "\b"
  print chars[@loading_index]
  @loading_index += 1
  @loading_index = 0 if @loading_index == chars.length
end

def print_rules(rules)
  rules.each_with_index do |rule, index|
    puts "#{index + 1}. #{rule.to_s}"
  end
end

# Iterate on the rules and call it recursively on each candidate.
#
# After each candidate apply method call, it is possible I will need to call
# the rule's process because some of the rules can write two things in one
# row. The apply will write one of them, but the other must follow the rule
# process normally
def fill_in_matrix(matrix, rules)
  print_loading

  current_rules = rules.dup
  while rule = current_rules.shift
    current_candidates = rule.find_candidates(matrix)
    next if current_candidates.count == 0

    @logger.log ''
    @logger.log "Trying rule #{rule.to_s.yellow} with #{current_candidates.count} candidates"

    index = 0
    while candidate = current_candidates.shift
      @logger.log("* [#{rule.to_s.yellow}] Candidate #{index.to_s.magenta}: #{candidate.inspect}... ", 'print')
      index += 1

      current_matrix = matrix.clone
      line = candidate[:line]
      column = candidate[:column]

      candidate_content = current_matrix[line, column]
      if !candidate_content.empty? && candidate_content != candidate[:value]
        @logger.log "#{current_matrix[line, column]} is not blank. #{"Failed".red}" and next
      elsif candidate_content != candidate[:value] && current_matrix.column_with(content: candidate[:value], line: line)
        @logger.log "#{candidate[:value]} is already used. #{"Failed".red}" and next
      end

      @logger.log 'OK'.green
      rule.apply(current_matrix, line, column, candidate[:value])

      if rule.process(current_matrix)
        if current_rules.empty?
          if current_matrix.complete?
            show_result(current_matrix)
          end
        else
          @logger.log "++ Starting recursion to #{current_rules.first.to_s} ++"
          fill_in_matrix(current_matrix, current_rules)
        end
      else
        @logger.log 'rule failed'.red
      end
    end
  end
end

def show_result(matrix)
  print "\b" unless @logger.loggin?
  puts ''
  matrix.show do |_|
    print "#{LAST_CELL_CONTENT.rjust(20, ' ')} ".green
  end
  puts ''

  exit 1
end

def apply_initial_rules(matrix, rules)
  failed_rules = []
  rules.each do |rule|
    if rule.process(matrix)
      rule.status = :applied
    else
      failed_rules << rule
    end
  end

  if failed_rules.length != rules.length
    apply_initial_rules(matrix, failed_rules)
  end
end

def remove_used_rules(rules)
  rules.reject { |rule| rule.status == :applied }
end

def start
  matrix = InitialSetup.build_initial_matrix
  rules = InitialSetup.rules

  print_rules(rules)
  puts ''
  matrix.show

  puts ''
  puts '*' * 130
  puts ''
  apply_initial_rules(matrix, rules)
  puts 'First rules applied:'
  puts rules.select { |rule| rule.status == :applied }.map(&:to_s).join("\r\n").yellow
  puts
  rules = remove_used_rules(rules)
  print 'Calculating....'.green
  fill_in_matrix(matrix, rules)
  puts 'Solution not found'
end

start
