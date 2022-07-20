require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/cell_creator'

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
    # board.place(cruiser, ["A1", "A2", "A3"])
    # expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq(true)
    expect(board.valid_placement?(submarine, ["A1,B1"])).to eq(false)
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
    #invalid duplicate
    expect(board.valid_placement?(submarine, ["A1", "A1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A1", "A1", "A2"])).to eq(false)
    # invalid backwards
    expect(board.valid_placement?(submarine, ["A2", "A1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
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
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq(true)
    # adjacent letters returns true
    expect(board.valid_placement?(submarine, ["A4", "B4"])).to eq(true)
    expect(board.valid_placement?(cruiser, ["A1", "B1", "C1"])).to eq(true)
  end


  it 'place_ship' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(cruiser, ["C1", "C2", "C3"])
    board.place(submarine, ["B1", "B2"])
    cell_1 = board.cells["C1"]
    cell_2 = board.cells["C2"]
    cell_3 = board.cells["C3"]
    cell_4 = board.cells["B1"]
    cell_5 = board.cells["B2"]
    cell_16 = board.cells["D4"]
    expect(cell_1.ship).to eq(cruiser)
    expect(cell_2.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cruiser)
    expect(cell_4.ship).to eq(submarine)
    expect(cell_5.ship).to eq(submarine)
    expect(cell_3.ship == cell_2.ship).to eq(true)
    expect(cell_4.ship == cell_5.ship).to eq(true)
    expect(cell_1.ship == cell_4.ship).to eq(false)
    expect(cell_16.ship).to eq(nil)
  end

  it 'overlap' do
    board = Board.new
    cruiser = Ship.new("MemeCruiser", 3)
    cruiser2 = Ship.new("Badcruiser", 3)
    cell_1 = board.cells["C1"]
    board.place(cruiser, ["C1", "C2", "C3"])
    expect(board.valid_placement?(cruiser2, ["C1", "C2", "C3"])).to eq(false)
    board.place(cruiser2,["C1", "C2", "C3"] )
    expect(cell_1.ship).to eq(cruiser)
  end

  it 'render' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    expect(board.render).to eq("\n  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    expect(board.render(true)).to eq("\n  1 2 3 4 \nA \e[36mS\e[0m \e[36mS\e[0m \e[36mS\e[0m . \nB . . . . \nC . . . . \nD . . . . \n")
  end
end

