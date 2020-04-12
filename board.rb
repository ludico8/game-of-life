require_relative 'cell.rb'

# In charge to initialize Board and its cells matrix
class Board
  attr_reader :rows, :cols, :cell_matrix, :cells

  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols
    @cells = []

    # let's create the matrix
    @cell_matrix = Array.new(rows) do |row|
      build_columns(row)
    end
  end

  # creates the columns needed by the matrix
  def build_columns(row)
    Array.new(@cols) do |col|
      cell = Cell.new(row, col)
      cells << cell
      cell
    end
  end
  
end