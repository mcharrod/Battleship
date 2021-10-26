require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'
require './lib/cpu_player'
require './lib/cell_creator'
require './lib/human_player'

RSpec.describe Game do
  it 'exists' do
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

  it 'human_player' do
      game = Game.new
      expect(game.human_player).to be_a(HumanPlayer)
  end

  it 'cpu_shot' do
    game = Game.new
    game.cpu_shot
    expect(game.human_board.cells.count {|key, value| value.fired_upon? == true}).to eq(1)
  end
end
