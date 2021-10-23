class Game
  attr_reader :human_board,
              :cpu_board
  def initialize
    @human_board = Board.new
    @cpu_board = Board.new
  end

   def welcome_message
     puts "Welcome to BATTLESHIP \n" +
     "Enter p to play. Enter q to quit."
      guess = gets.chomp
     if guess == "p"
       puts "we playin mofo"
     elsif guess == "q"
       exit
     else
       puts "Invalid input."
     end
   end

  #
  # def cpu_generate_ships
  # end
  #
  # def user_ship_input
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






end
