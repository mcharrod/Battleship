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

  it "cpu_generate_cruiser" do
    game = Game.new
    game.cpu_generate_cruiser
    expect(game.cpu_board.cells.count {|key, value| value.ship != nil}).to eq(3)
  end

  it "cpu_generate_sub" do
    game = Game.new
    game.cpu_generate_sub
    expect(game.cpu_board.cells.count {|key, value| value.ship != nil}).to eq(2)
  end

  it "cpu_shot" do
    game = Game.new
    game.cpu_shot
    expect(game.human_board.cells.count {|key, value| value.fired_upon? == true}).to eq(1)
    require "pry"; binding.pry
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