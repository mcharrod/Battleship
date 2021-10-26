class HumanPlayer

  attr_reader :human_board
  def initialize
    @human_board = Board.new
  end

  def human_lose?
    all_sunk =  @human_board.cells.values.count do |cell|
      if cell.ship != nil
        cell.ship.sunk?
        end
      end
    if all_sunk == 5
      return true
    end
  end

  def human_place_ship
    puts "Enter your ship's name!"
    ship_name = gets.chomp.strip
    puts "Enter your ships length! *4 or fewer chars"
    ship_length = gets.chomp.strip.to_i
    if ship_length > 4
      puts "Not a valid placement"
      human_place_ship
    end
    ship = Ship.new(ship_name, ship_length)
    puts "Now, enter the coordinates on this grid.."
    puts @human_board.render
    loop do
      input = gets.chomp.tr(',', ' ').upcase.strip
      cords = input.split
      if @human_board.valid_placement?(ship, cords)
        @human_board.place(ship, cords)
        break
      else
        puts "Not a valid placement."
        puts "Enter the squares for your ship #{ship_name}:"
      end
    end

  def human_place_sub
    submarine = Ship.new("Submarine", 2)
    loop do
      input = gets.chomp.tr(',', ' ').upcase.strip
      sub_cords = input.split
         if @human_board.valid_placement?(submarine, sub_cords)
         @human_board.place(submarine, sub_cords)
          break
          else
          puts "Not a valid placement."
          puts "Enter the squares for the submarine(2 spaces):"
        end
      end
    end
  end
end
