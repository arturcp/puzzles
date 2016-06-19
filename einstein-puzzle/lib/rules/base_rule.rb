class BaseRule
  attr_accessor :status, :candidates,
    # These attributes bellow are used to simplify the `combine` and `neighbor`
    # readbility. They are valid in the method context only, do not use them
    # outside it.
    :primary, :primary_line, :secondary, :secondary_line

  def combine(matrix, attribute1, attribute2)
    parse_attributes(attribute1, attribute2)

    primary_column = matrix.column_with(content: primary, line: primary_line)
    secondary_column = matrix.column_with(content: secondary, line: secondary_line)

    if primary_column && secondary_column && primary_column == secondary_column
      true
    elsif primary_column && !secondary_column && matrix[secondary_line, primary_column].empty?
      apply(matrix, secondary_line, primary_column, secondary)
      true
    elsif secondary_column && !primary_column && matrix[primary_line, secondary_column].empty?
      apply(matrix, primary_line, secondary_column, primary)
      true
    else
      false
    end
  end

  def neighbor(matrix, attribute1, attribute2)
    parse_attributes(attribute1, attribute2)

    column = matrix.column_with(content: primary, line: primary_line)
    secondary_column = matrix.column_with(content: secondary, line: secondary_line)

    if column && secondary_column && (column - secondary_column).abs == 1
      true
    elsif column && column == Table::HOUSE_1 && matrix[secondary_line, Table::HOUSE_2].empty? && !secondary_column
      apply(matrix, secondary_line, Table::HOUSE_2, secondary)
      true
    elsif column && column != Table::HOUSE_1 && matrix[secondary_line, column - 1].empty? && !matrix[secondary_line, column + 1] != '' && !secondary_column
      apply(matrix, secondary_line, column - 1, secondary)
      true
    elsif column && column != Table::HOUSE_5 && matrix[secondary_line, column + 1].empty? && matrix[secondary_line, column - 1] != '' && !secondary_column
      apply(matrix, secondary_line, column + 1, secondary)
      true
    else
      false
    end
  end

  # All Rules must have the apply method. It is used on the `process`
  # method and also when a candidate is being applied in the matrix.
  def apply(matrix, line, column, value)
    matrix[line, column] = value
  end

  # All Rules must have the candidates method. It contains the list of possible
  # solutions to the puzzle, respecting the given rule
  def find_candidates(matrix)
    list = []

    if column = matrix.column_with(content: candidate_value, line: candidate_line)
      list << {
        line: candidate_line,
        column: column,
        value: candidate_value
      }
    else
      matrix.row(candidate_line).to_a.each_with_index do |column, index|
        if column.empty? && !invalid_columns.include?(index)
          list << {
            line: candidate_line,
            column: index,
            value: candidate_value
          }
        end
      end
    end

    list
  end

  private

  def parse_attributes(attribute1, attribute2)
    self.primary = eval("#{self.class}::#{attribute1.upcase}")
    self.primary_line = eval("Table::#{attribute1.upcase}_LINE")
    self.secondary = eval("#{self.class}::#{attribute2.upcase}")
    self.secondary_line = eval("Table::#{attribute2.upcase}_LINE")
  end

  protected

  def invalid_columns
    []
  end

  def candidate_line
    eval("Table::#{self.class.constants.first}_LINE")
  end

  def candidate_value
    eval("#{self.class}::#{self.class.constants.first.to_s}")
  end
end