require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do

  it 'exists' do
    board = Board.new
    expect(board).to be_a(Board)
  end

  it 'cells' do
    board = Board.new
    expect(board.cells).to be_a(Hash)
    # require 'pry'; binding.pry
    # want to incorporate more tests when we talk w instructers
    expect(board.cells.count).to eq(16)
  end

  it 'valid coordinate' do
    board = Board.new
    expect(board.valid_coordinate?("A1")).to be(true)
    expect(board.valid_coordinate?("E1")).to be(false)
    expect(board.valid_coordinate?("D4")).to be(true)
    expect(board.valid_coordinate?("A5")).to be(false)
    expect(board.valid_coordinate?("A22")).to be(false)
  end

  it 'valid placement false' do
    board = Board.new
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    # length issues return false
    expect(board.valid_placement?(submarine, ["A1", "A2", "A3"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
    # letter gaps return false
    expect(board.valid_placement?(submarine, ["A4", "C4"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A1", "B1", "D1"])).to eq(false)
    # number gaps return false
    expect(board.valid_placement?(submarine, ["A4", "A2"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A4", "A1", "A2"])).to eq(false)
    # diagonals return false
    expect(board.valid_placement?(submarine, ["A1", "B2"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
  end

  it 'valid placement true' do
    board = Board.new
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    # appropriate length returns true
    expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq(true)
    # adjacent numbers returns true
    expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
    expect(board.valid_placement?(cruiser, ["A4", "A3", "A2"])).to eq(true)
    # adjacent letters returns true
    expect(board.valid_placement?(submarine, ["A4", "B4"])).to eq(true)
    expect(board.valid_placement?(cruiser, ["A1", "B1", "C1"])).to eq(true)
  end
end

