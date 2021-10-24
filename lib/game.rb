require './lib/board'

class Game
  attr_reader :human_board,
              :cpu_board,
              :cruiser_cords
  def initialize
    @human_board = Board.new
    @cpu_board   = Board.new
    # @cpu_submarine = Ship.new("Submarine", 2)
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







