class Board
  attr_reader :cells
  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false if coordinates.count != ship.length
    return false if overlap?(coordinates) == true

    if adjacent_letters?(coordinates) || adjacent_numbers?(coordinates)
      true
    else
      false
    end
  end

  def adjacent_letters?(coordinates)
    letters = []
    numbers = []
    coordinates.each do |coordinate|
      letters << coordinate[0] && numbers << coordinate[1].to_i
    end
      letters.sort.each_cons(2).all? do |char1, char2|
      char2.ord - char1.ord == 1 && numbers.uniq.count == 1
    end
  end

  def adjacent_numbers?(coordinates)
    letters = []
    numbers = []
    coordinates.each do |coordinate|
      letters << coordinate[0] && numbers << coordinate[1].to_i
    end
    numbers.sort.each_cons(2).all? do |num1, num2|
      num2 - num1 == 1 && letters.uniq.count == 1
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates) == true
    coordinates.each do |coord|
      matching_coords = @cells.find_all do |cell|
        cell[1].coordinate == coord
      end
      matching_coords.each do |cell_object|
        cell_object[1].place_ship(ship)
      end
      end
    end
  end

  def overlap?(coordinates)
    coordinates.any? do |coordinate|
      @cells[coordinate].ship != nil
    end
  end

  def render(reveal = false)
    if reveal == false
      board_render = "  1 2 3 4 \n" +
      "A #{@cells["A1"].render(reveal)} #{@cells["A2"].render(reveal)} #{@cells["A3"].render(reveal)} #{@cells["A4"].render(reveal)}\n" +
      "B #{@cells["B1"].render(reveal)} #{@cells["B2"].render(reveal)} #{@cells["B3"].render(reveal)} #{@cells["B4"].render(reveal)}\n" +
      "C #{@cells["C1"].render(reveal)} #{@cells["C2"].render(reveal)} #{@cells["C3"].render(reveal)} #{@cells["C4"].render(reveal)}\n" +
      "D #{@cells["D1"].render(reveal)} #{@cells["D2"].render(reveal)} #{@cells["D3"].render(reveal)} #{@cells["D4"].render(reveal)}\n"
    elsif reveal == true
      board_render =  "  1 2 3 4 \n" +
      "A #{@cells["A1"].render(reveal)} #{@cells["A2"].render(reveal)} #{@cells["A3"].render(reveal)} #{@cells["A4"].render(reveal)}\n" +
      "B #{@cells["B1"].render(reveal)} #{@cells["B2"].render(reveal)} #{@cells["B3"].render(reveal)} #{@cells["B4"].render(reveal)}\n" +
      "C #{@cells["C1"].render(reveal)} #{@cells["C2"].render(reveal)} #{@cells["C3"].render(reveal)} #{@cells["C4"].render(reveal)}\n" +
      "D #{@cells["D1"].render(reveal)} #{@cells["D2"].render(reveal)} #{@cells["D3"].render(reveal)} #{@cells["D4"].render(reveal)}\n"
    end
    board_render
    require "pry"; binding.pry
  end
end






