require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'
require './lib/cpu_player'
require './lib/cell_creator.rb'

RSpec.describe CpuPlayer do

  it 'exists' do
    cpu = CpuPlayer.new
    expect(cpu).to be_a(CpuPlayer)
  end

  it 'creates cpu board' do
    cpu = CpuPlayer.new
    expect(cpu.cpu_board).to be_a(Board)
  end
#
  it "cpu_generate_cruiser" do
    cpu = CpuPlayer.new
    cpu.cpu_generate_cruiser
    expect(cpu.cpu_board)
  end

  # it "cpu_generate_sub" do
  #   cpu = CpuPlayer.new
  #   cpu.cpu_generate_sub
  #   expect(cpu.cpu_board.cells.count {|key, value| value.ship != nil}).to eq(2)
  # end

  it 'cpu lose' do
      cpu = CpuPlayer.new
    expect(cpu.cpu_lose?)
   end
end
