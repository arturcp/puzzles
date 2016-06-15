require 'matrix'

class Matrix
  def []=(row, column, value)
    @rows[row][column] = value
  end
end
