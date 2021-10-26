require './lib/ship'

RSpec.describe Ship do
  it 'exists' do
    cruiser = Ship.new("Cruiser", 3)
    expect(cruiser).to be_a(Ship)
  end

  it 'has a name' do
    cruiser = Ship.new("Cruiser", 3)
    expect(cruiser.name).to eq("Cruiser")
  end

  it 'has a length' do
    cruiser = Ship.new("Cruiser", 3)
    expect(cruiser.length).to eq(3)
  end

  it 'has a health' do
    cruiser = Ship.new("Cruiser", 3)
    expect(cruiser.health).to eq(3)
  end

  it 'is not sunk by default' do
    cruiser = Ship.new("Cruiser", 3)
    expect(cruiser.sunk?).to eq(false)
  end

  it 'takes hit' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    expect(cruiser.health).to eq(2)
  end

  it 'cruiser is sunk after 3 hits' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    cruiser.hit
    expect(cruiser.health).to eq(1)
    cruiser.hit
    expect(cruiser.sunk?).to be(true)
  end
end
