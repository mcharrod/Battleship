require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'

RSpec.describe Game do
  it "exists" do
    board = Board.new
    human_board = Board.new
    cpu_board = Board.new
    game = Game.new(human_board, cpu_board)
    expect(game).to be_a(Game)
  end

  it 'board' do
    human_board = Board.new
    cpu_board = Board.new
    game = Game.new(human_board, cpu_board)
    expect(game.human_board).to be_a(Board)
    expect(game.cpu_board).to be_a(Board)
    cruiser = Ship.new("MemeCruiser", 3)
    human_board.place(cruiser, ["A1", "A2", "A3"])
  end
end