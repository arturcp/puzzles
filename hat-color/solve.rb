require 'byebug'
require_relative 'lib/extension'
require_relative 'lib/initial_setup'
require_relative 'lib/table'

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
    puts "#{index + 1}. #{rule.new.to_s}"
  end
end

def print_matrix(matrix)
  matrix.column_count.times do |j|
    matrix.row_count.times do |i|
      print "#{matrix[j, i].rjust(20, ' ')} "
    end
    puts ''
  end
end

def find_logical_data(matrix, rules)
  failed_rules = []
  rules.each do |rule|
    failed_rules << rule unless rule.new.process(matrix)
  end

  if failed_rules.length == rules.length
    print_matrix(matrix)
  else
    find_logical_data(matrix, failed_rules)
  end
end

def start
  matrix = build_initial_matrix
  rules = InitialSetup.rules
  print_matrix(matrix)
  puts ''
  print_rules(rules)

  puts '*' * 100
  find_logical_data(matrix, rules)
end

start
