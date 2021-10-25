require './lib/board'

class Game
  attr_reader :human_board,
              :cpu_board,
              :cruiser_cords
  def initialize
    @human_board = Board.new
    @cpu_board   = Board.new
  end

  def welcome_message
     puts "Welcome to BATTLESHIP \n" +
     "Enter p to play. Enter q to quit."
     player_input = gets.chomp.downcase.strip

     until ["p","q"].include?(player_input)
       puts "Invalid input. Try again!"
       player_input = gets.chomp.downcase.strip
     end
    if player_input == "p"
        cpu_generate_ships
        game_setup
    elsif player_input == "q"
       puts "You can't touch dis boat!"
       exit
     end
   end

   def game_setup
     puts "I have laid out my ships on the grid."
     puts "You now need to lay out your two ships."
     puts "The cruiser is 3 units long and the submarine is two units long."
     puts " #{@cpu_board.render}"
     puts "Enter the squares for the cruiser(3 spaces):"
     human_place_cruiser
     puts "You put the ship down. This is your board: #{@human_board.render(true)}"
     puts "Here's the cpu board dirty cheater:"
     puts "#{@cpu_board.render(true)}"
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
    #smashed together word edcgecase -- a1a2a3
  end

  # def human_place_sub
  # end


  def cpu_generate_ships
    cpu_cruiser = Ship.new("Cruiser", 3)
    loop do
      cruiser_cords = []
      until cruiser_cords.length == cpu_cruiser.length do
        cruiser_cords << @cpu_board.cells.keys.sample
      end
      if @cpu_board.valid_placement?(cpu_cruiser, cruiser_cords)
        @cpu_board.place(cpu_cruiser, cruiser_cords)
        break
      end
    end
    cpu_sub = Ship.new("Submarine", 2)
    loop do
      sub_cords = []
      until sub_cords.length == cpu_sub.length do
        sub_cords << @cpu_board.cells.keys.sample
      end
      if @cpu_board.valid_placement?(cpu_sub, sub_cords)
        @cpu_board.place(cpu_sub, sub_cords)
        break
      end
    end
  end
end



