require 'rspec'
require_relative 'cell.rb'
require_relative 'cell_utilities.rb'
require_relative 'board.rb'
require_relative 'game.rb'

describe 'Game of life' do
  include CellUtilities

  let!(:board) { Board.new }
  let!(:cell) { Cell.new(1,1) }

  context 'Cell' do
    subject {Cell.new}
    it 'should create a new cell object' do
      expect(subject).to be_a(Cell)
    end

    it 'should respond to proper methods' do
      expect(subject).to respond_to(:alive)
      expect(subject).to respond_to(:x)
      expect(subject).to respond_to(:y)
      expect(subject).to respond_to(:alive?)
      expect(subject).to respond_to(:dead?)
      expect(subject).to respond_to(:die!)
      expect(subject).to respond_to(:revive!)
    end
    
    it 'should initialize by default as a dead cell' do
      expect(subject.alive).to be false
    end
  end

  context 'Board' do
    subject { Board.new }

    it 'should create a new board object' do
      expect(subject).to be_a(Board) 
    end

    it 'should respond to proper methods' do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
      expect(subject).to respond_to(:cell_matrix)
      expect(subject).to respond_to(:cells)
      expect(subject).to respond_to(:get_live_neighbors)
      expect(subject).to respond_to(:auto_populate)
      expect(subject).to respond_to(:get_live_cells)
    end
    it 'should create proper cell matrix on initialization' do
      expect(subject.cell_matrix.is_a?(Array)).to be true
      subject.cell_matrix.each do |row|
        expect(row.is_a?(Array)).to be true
        row.each do |cell|
          expect(cell).to be_a(Cell)
        end
      end
    end
    it 'should detect a neighbors to the North' do
      cell_to_check = subject.cell_matrix[0][1]
      expect(cell_to_check.dead?).to be true
      cell_to_check.alive = true
      expect(cell_to_check.alive?).to be true
      expect(subject.get_live_neighbors(cell).count).to eq(1)
    end

    it 'should detect a neighbors to the North West' do
      expect(subject.cell_matrix[0][0].dead?).to be true
      subject.cell_matrix[0][0].alive = true
      expect(subject.cell_matrix[0][0].alive?).to be true
      expect(subject.get_live_neighbors(cell).count).to eq(1)
    end

    it 'should detect a neighbors to the North East' do
      expect(subject.cell_matrix[0][2].dead?).to be true
      subject.cell_matrix[0][2].alive = true
      expect(subject.cell_matrix[0][2].alive?).to be true
      expect(subject.get_live_neighbors(cell).count).to eq(1)
    end

    it 'should detect a neighbors to the Weast' do
      expect(subject.cell_matrix[1][0].dead?).to be true
      subject.cell_matrix[1][0].alive = true
      expect(subject.cell_matrix[1][0].alive?).to be true
      expect(subject.get_live_neighbors(cell).count).to eq(1)
    end

    it 'should detect a neighbors to the East' do
      expect(subject.cell_matrix[1][2].dead?).to be true
      subject.cell_matrix[1][2].alive = true
      expect(subject.cell_matrix[1][2].alive?).to be true
      expect(subject.get_live_neighbors(cell).count).to eq(1)
    end

    it 'should detect a neighbors to the South Weast' do
      expect(subject.cell_matrix[2][0].dead?).to be true
      subject.cell_matrix[2][0].alive = true
      expect(subject.cell_matrix[2][0].alive?).to be true
      expect(subject.get_live_neighbors(cell).count).to eq(1)
    end

    it 'should detect a neighbors to the South East' do
      expect(subject.cell_matrix[2][2].dead?).to be true
      subject.cell_matrix[2][2].alive = true
      expect(subject.cell_matrix[2][2].alive?).to be true
      expect(subject.get_live_neighbors(cell).count).to eq(1)
    end
    it 'should detect a neighbors to the South' do
      expect(subject.cell_matrix[2][1].dead?).to be true
      subject.cell_matrix[2][1].alive = true
      expect(subject.cell_matrix[2][1].alive?).to be true
      expect(subject.get_live_neighbors(cell).count).to eq(1)
    end
    it 'should randomly populate the board' do
      expect(subject.get_live_cells.count).to eq(0)
      subject.auto_populate
      expect(subject.get_live_cells.count).not_to eq(0)
    end
  end

  context 'CellUtilities' do
    subject { Cell.new(1, 1) }
    it 'should detect this particular cell should be live' do 
      # Rule 2. Any live cell with two or three live neighbours lives on to the next generation.
      expect(cell_validation(3, subject, true)[0].count).to eq(1)
    end
    it 'should detect this particular cell should be revive' do
      # Rule 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
      expect(cell_validation(3, subject, false)[0].count).to eq(1)
    end
    it 'should detect this particular cell should die' do
      # Rule 3. Any live cell with more than three live neighbours dies, as if by overpopulation.
      expect(cell_validation(4, subject, true)[1].count).to eq(1) 
    end
    it 'should detect this particular cell should live' do
      # Rule 1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
      expect(cell_validation(1, subject, true)[1].count).to eq(1)
    end
    it 'should detect the proper amount of coordinates to verify' do
      expect(get_coordinates_to_verify([1, 1],[3, 3]).count).to eq(8)
      expect(get_coordinates_to_verify([0, 0],[3, 3]).count).to eq(3)
    end
  end

  context 'Game' do
    subject { Game.new }

    it 'should create a new game object' do
      expect(subject).to be_a(Game)
    end

    it 'should respond to proper methods' do
      expect(subject).to respond_to(:board)
      expect(subject).to respond_to(:seeds)
      expect(subject).to respond_to(:play)
    end

    it 'should initializa with proper attributes' do
      expect(subject.board).to be_a(Board)
      expect(subject.seeds).to be_a(Array)
    end

    it 'should set seeds properly' do
      game = Game.new(board, [ [2,1], [2,0] ])
      expect(game.board.cell_matrix[2][1].alive?).to be true
      expect(game.board.cell_matrix[0][0].dead?).to be true
    end
  end

  context 'Rules' do
    let!(:game) {Game.new}
    context 'Rule 1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.' do 
      it 'should kill a live cell with 1 live neighbour' do
        game.board.cell_matrix[1][1].alive = true
        expect(game.board.cell_matrix[1][1].alive?).to be true
        game.play
        expect(game.board.cell_matrix[1][1].dead?).to be true
      end

      it 'should kill a live cell with 1 live neighbour' do
        game = Game.new(board, [ [0, 1], [0, 2] ])
        game.play
        expect(game.board.cell_matrix[0][1].dead?).to be true
        expect(game.board.cell_matrix[0][2].dead?).to be true
      end

      it 'Doesnt kill live cell with 2 neighbors' do
        game = Game.new(board, [ [0, 0], [0, 1], [0, 2] ])
        game.play
        expect(game.board.cell_matrix[0][1].alive?).to be true
      end
    end

    context 'Rule 2. Any live cell with two or three live neighbours lives on to the next generation.' do
      it 'should keep alive cell with 2 neighbors to next generation' do
        game = Game.new(board, [ [0, 0], [0, 1], [0, 2] ])
        board.get_live_neighbors(board.cell_matrix[0][1])
        game.play
        expect(game.board.cell_matrix[0][1].alive?).to be true
      end

      it 'should keep alive cell with 3 neighbors to next generation' do
        game = Game.new(board, [ [0, 1], [1, 1], [2, 1], [2, 2] ])
        expect(board.get_live_neighbors(board.cell_matrix[1][1]).count).to eq(3)
        game.play
        expect(game.board.cell_matrix[0][1].dead?). to be true
        expect(game.board.cell_matrix[1][1].alive?). to be true
        expect(game.board.cell_matrix[2][1].alive?). to be true
        expect(game.board.cell_matrix[2][2].alive?). to be true
      end
    end

    context 'Rule 3. Any live cell with more than three live neighbours dies, as if by overpopulation.' do
      it 'should kill live cell with more than 3 live neighbors' do
        game = Game.new(board, [ [0, 1], [1, 1], [2, 1], [2, 2], [1, 2] ])
        expect(board.get_live_neighbors(board.cell_matrix[1][1]).count).to eq(4)
        game.play
        expect(game.board.cell_matrix[0][1].alive?). to be true
        expect(game.board.cell_matrix[1][1].dead?). to be true
        expect(game.board.cell_matrix[2][1].alive?). to be true
        expect(game.board.cell_matrix[2][1].alive?). to be true
        expect(game.board.cell_matrix[2][2].alive?). to be true
        expect(game.board.cell_matrix[1][2].dead?). to be true
      end
    end

    context 'Rule 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.' do
      it 'revives a dead cell when it has 3 live neighbors' do
        game = Game.new(board, [ [0, 1], [1, 1], [2, 1] ])
        expect(board.get_live_neighbors(board.cell_matrix[1][0]).count).to eq(3)
        game.play
        expect(game.board.cell_matrix[1][0].alive?). to be true
        expect(game.board.cell_matrix[1][2].alive?). to be true
      end
    end
  end
end