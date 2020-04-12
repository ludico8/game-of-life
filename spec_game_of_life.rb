require 'rspec'
require_relative 'cell.rb'
require_relative 'cell_utilities.rb'
require_relative 'board.rb'

describe 'Game of life' do
  include CellUtilities

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
  end
end