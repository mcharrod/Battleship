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

  def human_place_cruiser
    cruiser = Ship.new("Cruiser", 3)
    loop do
      input = gets.chomp.tr(',', ' ').upcase.strip
      cruiser_cords = input.split
      if @human_board.valid_placement?(cruiser, cruiser_cords)
        @human_board.place(cruiser, cruiser_cords)
        break
      else
        puts "Not a valid placement."
        puts "Enter the squares for the cruiser(3 spaces):"
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
