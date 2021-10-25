require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'
require './lib/cpu_player'

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

  it 'cpu player' do
    game = Game.new
    expect(game.cpu_player).to be_a(CpuPlayer)
  end



  it "cpu_shot" do
    game = Game.new
    game.cpu_shot
    expect(game.human_board.cells.count {|key, value| value.fired_upon? == true}).to eq(1)
  end
  #
  # it "game_setup" do
  #   game = Game.new
  #   expect(game.game_setup).to be_a(String)
  # end
  #
  # it "human place cruiser" do
  #   game = Game.new
  #   expect(game.human_place_cruiser)
  # end
  #
  # it "human place sub" do
  #   game = Game.new
  #   expect(game.human_place_cruiser)
  # end








end
