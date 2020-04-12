require 'rspec'
require_relative 'cell.rb'
require_relative 'board.rb'

describe 'Game of life' do

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
    end

  end
end