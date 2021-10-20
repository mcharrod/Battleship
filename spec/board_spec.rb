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


end
