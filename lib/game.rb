

#
# bug  list:
# lowercase chars in order a1a2a3
# backwards placement freeze game a3a2a1
  #smashed together word edcgecase -- a1a2a3
#computer does not fire on same spot twice
#human informed they fire on same spot
#player input as variable
#number lineup on game setup
#build out spec
#q keeps game playing

# feature list:
# need shot_fired counter, timer, intelligent computer, dynamic user generated board, custom ships


class Game
  attr_reader :human_board,
              :cpu_board,
              :cruiser_cords,
              :cpu_player,
              :human_player
  def initialize
    @human_board = Board.new
    @human_player = HumanPlayer.new
    @cpu_player  = CpuPlayer.new
    @cpu_board   = cpu_player.cpu_board
    @human_board = human_player.human_board
    # create an instance of the class;
    # THEN recall that instance and class
    # method.
  end

  def player_input
    gets.chomp
  end

  def welcome_message
     puts "Welcome to BATTLESHIP \n" +
     "Enter p to play. Enter q to quit."
     player_input.downcase.strip
     until ["p","q"].include?(player_input)
       puts "Invalid input. Try again!"
       player_input.downcase.strip
     end
    if player_input == "p"
        @cpu_player.cpu_generate_cruiser
        @cpu_player.cpu_generate_sub
        game_setup
    elsif player_input == "q"
      system "clear"
      puts "\e[34m#{"Sleep with da fishes!!!"}\e[0m"
      sleep(2)
      1000.times do
        print "🐟🌊"
      end
       exit
     end
   end

   def game_setup
     puts "I have laid out my ships on the grid."
     puts "You now need to lay out your two ships."
     puts "The cruiser is 3 units long and the submarine is two units long."
     puts " #{@cpu_board.render}"
     puts "Enter the squares for the cruiser(3 spaces):"
     @human_player.human_place_cruiser
     puts "You put the ship down. This is your board: \n #{@human_board.render(true)}"
     puts "Enter the squares for the submarine(2 spaces):"
     @human_player.human_place_sub
     puts "You put the ship down. This is your board: \n #{@human_board.render(true)}"
     sleep(3)
     system "clear"
     game_body
   end

   def game_body
     # call human class/ call cpu class
     until @human_player.human_lose? || @cpu_player.cpu_lose?
       puts "=============COMPUTER BOARD============= \n"
       puts "#{@cpu_board.render}\n"
       cpu_shot
       puts "==============PLAYER BOARD=============="
       puts "#{@human_board.render(true)}"
       human_shot
      end
      # if human_lose || @cpu_player.cpu_lose?
   end

   def cpu_shot
     puts "Computer shot inbound!"
     sleep(2)
     firing_coords = @human_board.cells.keys.sample
     @human_board.cells[firing_coords].fire_upon
     if @human_board.cells[firing_coords].fired_upon? && @human_board.cells[firing_coords].empty?
       puts "Shot was a miss!"
     elsif @human_board.cells[firing_coords].fired_upon? && @human_board.cells[firing_coords].ship.sunk? == false && @human_board.cells[firing_coords].empty? == false
       puts "Hit on #{@human_board.cells[firing_coords].coordinate}! Ouch!"
     elsif @human_board.cells[firing_coords].ship.sunk?
       puts "You sunk my boat!"
     end
   end

  def human_shot
    puts "Enter coordinates to fire upon, mon Capitan!"
    loop do
      firing_coords = player_input.tr(',', ' ').upcase.strip
      if @cpu_board.valid_coordinate?(firing_coords)
        @cpu_board.cells[firing_coords].fire_upon
          if @cpu_board.cells[firing_coords].fired_upon? && @cpu_board.cells[firing_coords].empty?
            puts "Shot was a miss!"
          elsif @cpu_board.cells[firing_coords].fired_upon? && @cpu_board.cells[firing_coords].ship.sunk? == false && @cpu_board.cells[firing_coords].empty? == false
            puts "Hit on #{@cpu_board.cells[firing_coords].coordinate}!"
          elsif @cpu_board.cells[firing_coords].ship.sunk?
            puts "You sunk the cpu's ship!"
          end
        break
      else
        puts "That coordinate does not exist on the board."
        puts "try again"
      end
    end
  end
end


