# Module incharge to contain utilities for cells
module CellUtilities

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
