class BaseRule
  attr_accessor :status, :candidates,
    # These attributes bellow are used to simplify the `combine` and `neighbor`
    # readbility. They are valid in the method context only, do not use them
    # outside it.
    :primary, :primary_line, :secondary, :secondary_line

  def combine(matrix, attribute1, attribute2)
    parse_attributes(attribute1, attribute2)

    if column = matrix.column_with(content: primary, line: primary_line) && matrix[secondary_line, column] == ''
      apply(matrix, primary_line, column, primary)
      true
    elsif column = matrix.column_with(content: secondary, line: secondary_line) && matrix[primary_line, column] == ''
      apply(matrix, secondary_line, column, secondary)
      true
    else
      self.candidates = candidates(matrix, primary_line, primary)
      false
    end
  end

  def neighbor(matrix, attribute1, attribute2)
    parse_attributes(attribute1, attribute2)

    column = matrix.column_with(content: primary, line: primary_line)

    if column == Table::HOUSE_1 && matrix[secondary, Table::HOUSE_2] == ''
      apply(matrix, secondary_line, column, secondary)
      true
    elsif column && column != Table::HOUSE_1 && column != Table::HOUSE_5 && matrix[secondary_line, column - 1] == '' && matrix[secondary_line, column + 1] != ''
      apply(matrix, secondary_line, column - 1, secondary)
      true
    elsif column && column != Table::HOUSE_1 && column != Table::HOUSE_5 && matrix[secondary_line, column + 1] == '' && matrix[secondary_line, column - 1] != ''
      apply(matrix, secondary_line, column + 1, secondary)
      true
    else
      self.candidates = candidates(matrix, primary_line, primary)
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
  def candidates(matrix, line, value)
    list = []

    matrix.row(line).to_a.each_with_index do |column, index|
      list << {
        line: line,
        column: index + 1,
        value: value
      } if column == ''
    end

    list
  end

  private

  def parse_attributes(attribute1, attribute2)
    self.primary = eval("#{self.class}::#{attribute1.upcase}"),
    self.primary_line = eval("Table::#{attribute1.upcase}_LINE"),
    self.secondary = eval("#{self.class}::#{attribute2.upcase}"),
    self.secondary_line = eval("Table::#{attribute2.upcase}_LINE")
  end

  # def parse(attribute1, attribute2)
  #   @parse ||= {
  #     primary: eval("#{self.class}::#{attribute1.upcase}"),
  #     primary_line: eval("Table::#{attribute1.upcase}_LINE"),
  #     secondary: eval("#{self.class}::#{attribute2.upcase}"),
  #     secondary_line: eval("Table::#{attribute2.upcase}_LINE")
  #   }
  # end
end
