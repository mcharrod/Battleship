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

  def valid_placement?(ship, cells)
    if cells.count != ship.length
      false
    elsif adjacent_letters?(cells) || adjacent_numbers?(cells)
      true
    else
      false
    end
  end

  def adjacent_letters?(cells)
    letters = []
    numbers = []
    cells.each do |cell|
      letters << cell[0] && numbers << cell[1].to_i
    end
      letters.sort.each_cons(2).all? do |char1, char2|
      char2.ord - char1.ord == 1 && numbers.uniq.count == 1
    end
  end

  def adjacent_numbers?(cells)
    letters = []
    numbers = []
    cells.each do |cell|
      letters << cell[0] && numbers << cell[1].to_i
    end
    numbers.sort.each_cons(2).all? do |num1, num2|
      num2 - num1 == 1 && letters.uniq.count == 1
    end
  end
end



