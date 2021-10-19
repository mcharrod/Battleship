class Cell
  attr_reader :coordinate, :ship, :fired_upon
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_arg)
    @ship = ship_arg
  end

  def fire_upon
    @fired_upon = true
    @ship.hit
  end

  def fired_upon?
    @fired_upon
  end

  
end
