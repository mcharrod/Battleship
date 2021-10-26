class HumanPlayer

  attr_reader :human_board
  def initialize
    @human_board = Board.new
  end

  def human_lose?
    all_sunk = @human_board.cells.values.count do |cell|
      cell.ship != nil && cell.ship.sunk?
      end
    all_placed_not_yet_sunk = @human_board.cells.values.count do |cell|
        cell.ship
      end
    if all_sunk == all_placed_not_yet_sunk
       return true
     end
  end

  def human_place_ship
    puts "Enter your ship's name:"
    ship_name = gets.chomp.strip
    (1)
    puts "Enter your ship's length(min 1, max 4)"
    puts "A ship's length is equal to it's health."
    ship_length = gets.chomp.strip.to_i
    if ship_length > 4 || ship_length == 0
      puts "Not a valid length."
      human_ship_setup
    else
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
    end 
  end
end
