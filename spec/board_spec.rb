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

  it 'valid placement length' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    # board.valid_placement?(cruiser, ["A1", "A2"])
    board.valid_placement?(submarine, ["A2", "A3", "A4"])
  #  expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A4", "A2", "A3"])).to eq(false)
  end

  it 'valid consecutive numbers' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
     expect(board.valid_placement_numbers(cruiser, ["A1", "A2", "A9"])).to eq(false)
     expect(board.valid_placement_numbers(cruiser, ["A1", "B2", "C3"])).to eq(false)
     expect(board.valid_placement_numbers(cruiser, ["A1", "A2", "A3"])).to eq(true)
  end

# letters not same  a1 b2 d3
# numbers not same
# a1 b1 c1

#check if numbers are same OR next to eachother
#check if letters are same OR  next to eachother

# letters must be same or consecutive && numbers must be same or consecutive

# base principlpe :
# if letters are consecutive.... check if numbers are same
# if numbers are consecutive.... check if letters are same


# if letters same, numbers MUST BE consecutive.
# if numbers same, letters MUST BE consecutive


# taken care of: letters are next to eachother
# taken care of: numbers are next to eachother
# split the elements into sets of numbers and letters
# array of letters
# array of numbers
# check if letters are all same
# if letters are same,
# numbers must be consecutive; use numbers.sort
# check if numbers are all same
# if numbers are same,
# letters must be consecutive.

# consecutive numbers strat:
# make pairs in arrays
# subtract first number from second number
# if diff is not equal to 1,
# numbers are not consecutive.

# do the same with the lettters ords


end
