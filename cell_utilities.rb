# Module incharge to contain utilities for cells
module CellUtilities

  # returns all the coordinates to verify for a cell based on its coordinate
  def get_coordinates_to_verify(coordinates, boundaries)
    verified_coordinates = { 'rows': [], 'cols': [] }
    
    coordinates.each_with_index do |coordinate , index|
      to_verify = []
      if coordinate == 0
        to_verify = [0, 1]
      else
        to_verify = [coordinate - 1, coordinate]
        last_coordinate = coordinate + 1
        to_verify << last_coordinate if last_coordinate < boundaries[index]
      end
      verified_coordinates["#{index == 0 ? 'rows' : 'cols'}"] = to_verify
    end

    verified_coordinates = verified_coordinates['rows'].product(verified_coordinates['cols'])
    # Skip our current position in the board
    verified_coordinates.delete_if { |coord| coord[0] === coordinates[0] && coord[1] === coordinates[1] }
    verified_coordinates
  end

  # it validates if a particular cell should live or die
  def cell_validation(total_neighbors, cell, alive)
    cell_to_revive, cell_to_kill = [], []
    
    # Rule 1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
    # Rule 3. Any live cell with more than three live neighbours dies, as if by overpopulation.
    cell_to_kill << cell if (alive && (total_neighbors < 2 || total_neighbors > 3))

    # Rule 2. Any live cell with two or three live neighbours lives on to the next generation.
    # Rule 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    cell_to_revive << cell if ([2,3].include?(total_neighbors) && alive) || (cell.dead? && total_neighbors == 3)
    return cell_to_revive, cell_to_kill
  end
end
