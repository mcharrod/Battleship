require './lib/cell_creator'
require './lib/board'
require './lib/cell'

RSpec.describe CellCreator do

  it 'exists' do
    cell_creator = CellCreator.new
    expect(cell_creator).to be_a(CellCreator)
  end

  it 'creates cells' do
      cell_creator = CellCreator.new
      expect(cell_creator.cells).to be_a(Hash)
      expect(cell_creator.cells.count).to eq(16)
    end
end