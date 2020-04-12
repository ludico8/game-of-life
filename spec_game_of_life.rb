require 'rspec'
require_relative 'cell.rb'

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
end