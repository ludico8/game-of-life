require_relative 'cell_utilities.rb'

# In charge to initialize a game and set seeds within the board
class Game
  include CellUtilities
  attr_reader :board, :seeds
  
  def initialize(board=Board.new, seeds=[])
    # Initialize Game
    @board = board
    @seeds = seeds
    run_seeds
  end

  # it set as alive the cells contained within the seeds coordinates array
  def run_seeds
    seeds.each do |seed|
      board.cell_matrix[seed[0]][seed[1]].alive = true
    end
  end

  # it runs all the game's validations
  def play
    cells_to_revive, cells_to_kill = [], []
    
    board.cells.each do |cell|
      total_neighbors = board.get_live_neighbors(cell).count
      to_revive, to_kill = cell_validation(total_neighbors, cell, cell.alive?)
      cells_to_revive = cells_to_revive + to_revive
      cells_to_kill =  cells_to_kill + to_kill
    end

    cells_to_revive.each { |dead_cell| dead_cell.revive! }
    cells_to_kill.each { |alive_cell| alive_cell.die! }
  end
end