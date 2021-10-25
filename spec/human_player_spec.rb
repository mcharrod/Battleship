require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'
require './lib/cpu_player'
require './lib/human_player'

RSpec.describe HumanPlayer do

  it 'exists' do
    human = HumanPlayer.new
    expect(human).to be_a(HumanPlayer)
  end

  it 'has player board' do
    human = HumanPlayer.new
    expect(human.human_board).to be_a(Board)
  end

  it 'player lose' do
    human = HumanPlayer.new
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Memecruiser", 3)
    human.human_board.place(submarine, ["A1", "A2"])
    human.human_board.place(cruiser, ["B1", "B2", "B3"])
    submarine.hit
    submarine.hit
    cruiser.hit
    cruiser.hit
    cruiser.hit
    expect(human.human_lose?).to be(true)
  end

end
