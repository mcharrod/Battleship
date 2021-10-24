require './lib/ship'
require './lib/cell'

# can we run Ship (class) tests from this test?
RSpec.describe Cell do
  it 'exists' do
    cell = Cell.new("B4")
    expect(cell).to be_a(Cell)
  end

  it 'gives coordinate' do
    cell = Cell.new("B4")
    expect(cell.coordinate).to eq("B4")
  end

  it 'ship is nil by default' do
    cell = Cell.new("B4")
    expect(cell.ship).to eq(nil)
  end

  it 'cell is empty by default' do
    cell = Cell.new("B4")
    expect(cell.empty?).to eq(true)
  end

  it 'it places a ship' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    expect(cell.ship).to eq(cruiser)
    expect(cell.empty?).to eq(false)
  end

  it 'fired_upon? is false by default' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    expect(cell.fired_upon?).to eq(false)
  end

  it 'it is fired upon' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    expect(cell.fired_upon?).to eq(true)
    expect(cell.ship.health).to eq(2)
  end

  it 'does not fire upon same coordinate' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    expect(cell.fired_upon?).to eq(true)
    expect(cell.ship.health).to eq(2)
    cell.fire_upon
    expect(cell.ship.health).to eq(2)
  end

  it 'renders without ship' do
    cell_1 = Cell.new("B4")
    cell_1.render
    expect(cell_1.render).to eq(".")
    cell_1.fire_upon
    expect(cell_1.render).to eq("M")
  end

  it 'renders with ship and counts hit' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    expect(cell_2.render).to eq("H")
    expect(cruiser.health).to eq(2)
  end

  it "renders reveal with true" do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    expect(cell_2.render(true)).to eq("S")
  end


  it "renders with ship and sink" do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    cruiser.hit
    cruiser.hit
    expect(cruiser.sunk?).to eq(true)
    expect(cell_2.render).to eq("X")
  end
end
