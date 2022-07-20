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
    print "Enter your ship's name: "
    ship_name = gets.chomp.strip
    (1)
    puts "Enter your ship's length(min 1, max 4)"
    puts "A ship's length is equal to it's health."
    ship_length = gets.chomp.strip.to_i
    if ship_length > 4 || ship_length == 0
      puts "Not a valid length."
      # future refactor: stop asking user to name ship after invalid input 
      human_place_ship
    else
      ship = Ship.new(ship_name, ship_length)
      puts "Now, enter the coordinates on this grid.."
      puts @human_board.render
      loop do
        input = gets.chomp.tr(',', ' ').upcase.strip
      if input.length == (ship_length * 2)
        input = input.gsub(/(.{2})/, '\1 ').strip
      end
        cords = input.split
      if @human_board.valid_placement?(ship, cords)
        @human_board.place(ship, cords)
        break
      else
        puts "Not a valid placement."
        puts "Enter the coordinates for your ship #{ship_name}:"
        end
      end
    end
  end
end
