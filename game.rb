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
  end
end