class BaseRule
  attr_accessor :primary, :secondary, :status

  # The contructor expects 3 keys: 2 for the attributes and 1
  # for the description
  def initialize(options = {})
    @description = options.delete(:description)
    @keys = options.keys
    @primary = options[@keys.first]
    @secondary = options[@keys.last]
  end

  # All Rules must have the apply method. It is used on the `process`
  # method and also when a candidate is being applied in the matrix.
  def apply(matrix, line, column, value)
    matrix[line, column] = value
  end

  # All Rules must have the candidates method. It contains the list of possible
  # solutions to the puzzle, respecting the given rule
  def find_candidates(matrix)
    primary_line = row_index(matrix, @keys.first)

    list = []

    if column = matrix.column_with(content: primary, line: primary_line)
      list << {
        line: primary_line,
        column: column,
        value: primary
      }
    else
      matrix.row(primary_line).to_a.each_with_index do |column, index|
        if column.empty?
          list << {
            line: primary_line,
            column: index,
            value: primary
          }
        end
      end
    end

    list
  end

  def to_s
    @description
  end

  protected

  def row_index(matrix, attribute)
    columns = matrix.column(0).to_a
    match = columns.find { |item| item.downcase == attribute.to_s }

    columns.index(match)
  end
end
