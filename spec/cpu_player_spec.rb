require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'
require './lib/cpu_player'

RSpec.describe CpuPlayer do

  it 'exists' do
    cpu = CpuPlayer.new
    expect(cpu).to be_a(CpuPlayer)
  end

  it 'creates cpu board' do
    cpu = CpuPlayer.new
    expect(cpu.cpu_board).to be_a(Board)
  end

  it "cpu_generate_cruiser" do
    cpu = CpuPlayer.new
    cpu.cpu_generate_cruiser
    expect(cpu.cpu_board.cells.count {|key, value| value.ship != nil}).to eq(3)
  end

  it "cpu_generate_sub" do
    cpu = CpuPlayer.new
    cpu.cpu_generate_sub
    expect(cpu.cpu_board.cells.count {|key, value| value.ship != nil}).to eq(2)
  end

  it 'cpu lose' do
    cpu = CpuPlayer.new
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Memecruiser", 3)
    cpu.cpu_board.place(submarine, ["A1", "A2"])
    cpu.cpu_board.place(cruiser, ["B1", "B2", "B3"])
    submarine.hit
    submarine.hit
    cruiser.hit
    cruiser.hit
    cruiser.hit
    expect(cpu.cpu_lose?).to be(true)
  end
end
