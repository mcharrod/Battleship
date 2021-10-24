require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'

RSpec.describe Game do
  it "exists" do
    game = Game.new
    expect(game).to be_a(Game)
  end

  it 'boards' do
    game = Game.new
    expect(game.human_board).to be_a(Board)
    expect(game.cpu_board).to be_a(Board)
  end

  xit "welcome_message" do
    game = Game.new
    expect(game.welcome_message)
    #not sure about testing yet, requires input
  end

  it "cpu_generate_ships" do
    game = Game.new
    game.cpu_generate_ships
    expect(game.cpu_board.cells.count {|key, value| value.ship != nil}).to eq(5)
  end






end