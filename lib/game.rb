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
      menu_select = $stdin.gets.chomp
     if menu_select == "p"
       puts "game on!"
     elsif menu_select == "q"
       exit
     else
       puts "Invalid input."
       welcome_message
     end
   end

    # user_place_ships
    def user_place_ships
      puts "\n"
      puts "I have laid out my ships on the grid."
      puts "You now need to lay out your two ships."
      puts "The Cruiser is three units long and the"
      puts "Submarine is two units long."
      puts human_board.render
      "Enter the squares for the Cruiser (3 spaces):"
      puts "> "
      human_ship1 = $stdin.gets.chomp
      # if human_ship1 != human_board.valid_coordinate?
      # puts "please enter coordinates on the grid."
      # puts " >"
      # human_board.place
      #
    end



   # place your ships!
   #

   # useful methods: render to print board
   # check if valid placement
   # display board with placed ships
   # prompt to place ships w coordinates like so:
   # A1, C5, board goes from A1 to D4
       # if valid coord

  #
  # def cpu_generate_ships

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
