class Board
  attr_reader :cells
  def initialize
    @cells = CellCreator.new.cells
  end

  def valid_coordinate?(coordinates)
    if (coordinates).is_a? String
      @cells.has_key?(coordinates)
    elsif (coordinates).is_a? Array
     coordinates.all? do |coordinate|
        @cells.has_key?(coordinate.upcase)
      end
    end
  end

  def valid_placement?(ship, coordinates)
    return false if !valid_coordinate?(coordinates)
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
      letters.each_cons(2).all? do |char1, char2|
      char2.ord - char1.ord == 1 && numbers.uniq.count == 1
    end
  end

  def adjacent_numbers?(coordinates)
    letters = []
    numbers = []
    coordinates.each do |coordinate|
      letters << coordinate[0] && numbers << coordinate[1].to_i
    end
    numbers.each_cons(2).all? do |num1, num2|
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
      board_render = "  1 2 3 4 \n" +
      "A #{@cells["A1"].render(reveal)} #{@cells["A2"].render(reveal)} #{@cells["A3"].render(reveal)} #{@cells["A4"].render(reveal)}\n" +
      "B #{@cells["B1"].render(reveal)} #{@cells["B2"].render(reveal)} #{@cells["B3"].render(reveal)} #{@cells["B4"].render(reveal)}\n" +
      "C #{@cells["C1"].render(reveal)} #{@cells["C2"].render(reveal)} #{@cells["C3"].render(reveal)} #{@cells["C4"].render(reveal)}\n" +
      "D #{@cells["D1"].render(reveal)} #{@cells["D2"].render(reveal)} #{@cells["D3"].render(reveal)} #{@cells["D4"].render(reveal)}\n"
  end
end






