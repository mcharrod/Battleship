class Cell
  attr_reader :coordinate,
              :ship,
              :fired_upon
  def initialize(coordinate)
    @coordinate = coordinate
    @ship       = nil
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
    if @ship != nil
      @ship.hit
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(reveal = false)
    return "S" if reveal == true
      if fired_upon? == false
        "."
      elsif fired_upon? && empty?
        "M"
      elsif fired_upon? && @ship.sunk? == false && empty? == false
        "H"
      elsif @ship.sunk?
        "X"
    end
  end
end
