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
    if fired_upon == true
      return
    end
      @fired_upon = true
      if @ship != nil
        @ship.hit
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(reveal = false)
      if !fired_upon? && reveal == true && !empty?
      "\033[36m#{"S"}\033[0m"
      elsif fired_upon? == false
        "."
      elsif fired_upon? && empty?
        "\033[35m#{"M"}\033[0m"
      elsif fired_upon? && @ship.sunk? == false && empty? == false
        "\033[31m#{"H"}\033[0m"
      elsif @ship.sunk?
        "\033[31m#{"X"}\033[0m"
    end
  end
end
