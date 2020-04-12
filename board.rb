require_relative 'cell.rb'
require_relative 'cell_utilities.rb'

# In charge to initialize Board and its cells matrix
class Board
  include CellUtilities
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

  # returns all the live neighbors around a particular cell
  def get_live_neighbors(cell)
    cooordinates = get_coordinates_to_verify([cell.x, cell.y], [self.rows, self.cols])
    live_neighbours = []
    cooordinates.each do |cord|
      current_cell = self.cell_matrix[cord[0]][cord[1]]
      live_neighbours << current_cell if current_cell.alive?
    end
    live_neighbours
  end

  # it set cells randomly as alive or dead
  def auto_populate
    cells.each { |cell| cell.alive = [true, false].sample }
  end

  # returns only alive cells
  def get_live_cells
    cells.select { |cell| cell.alive }
  end

end