class Game
  attr_reader :human_board,
              :cpu_board
  def initialize
    @human_board = Board.new
    @cpu_board   = Board.new
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Submarine", 2)
    @cruiser_cords = []
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
       puts "we playin"
    elsif player_input == "q"
       puts "You can't touch dis boat!"
       exit
     end
   end

   def cpu_generate_ships
      @cruiser_cords << @cpu_board.cells.keys.sample
      until @cpu_board.valid_placement?(@cpu_cruiser, @cruiser_cords) == false
        require "pry"; binding.pry
        cpu_generate_ships
      end
      @cpu_board.place(@cruiser, @cruiser_cords)
      end
    end


  #
  # def cpu_generate_ships -- CHRIS
  # end
  #
  # def user_ship_input -- KATY
  # end
  #
  # def take_turns
  # #   user.guess and fire
  # #   user 2.guess and fire
  # # end

  # def main_play_method
  #   #until @human_board.ship.length == @human_board.cells.sunk.count
  #   #alternate take_turns
  # end

  #def endgame
    #display counts, take user arg of what next, q exits, p returns to welcome_message







