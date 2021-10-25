#
# bug  list:
# lowercase chars in order a1a2a3
# backwards placement freeze game a3a2a1
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
              :cpu_player
  def initialize
    @human_board = Board.new
    @cpu_player  = CpuPlayer.new
    # create an instance of the class;
    # THEN recall that instance and class
    # method.
    @cpu_board   = @cpu_player.cpu_board
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
        cpu_generate_cruiser
        cpu_generate_sub
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
     human_place_cruiser
     puts "You put the ship down. This is your board: \n #{@human_board.render(true)}"
     puts "Enter the squares for the submarine(2 spaces):"
     human_place_sub
     puts "You put the ship down. This is your board: \n #{@human_board.render(true)}"
     sleep(3)
     system "clear"
     game_body
   end

   def game_body
     # call human class/ call cpu class
     until human_lose || cpu_lose
       puts "=============COMPUTER BOARD============= \n"
       puts "#{@cpu_board.render}\n"
       cpu_shot
       puts "==============PLAYER BOARD=============="
       puts "#{@human_board.render(true)}"
       human_shot
      end
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

   def human_lose_message
     puts "CPU loses!"
     sleep(3)
     puts "Press p to play again, or q to quit."
     player_input = gets.chomp.downcase.strip
     until ["p","q"].include?(player_input)
       puts "Invalid input. Try again!"
       user_input = gets.chomp.downcase.strip
       if player_input == "p"
         welcome_message
       elsif player_input == "q"
         puts "Sleep with da fishes!!!"
         sleep(2)
         65.times do
           puts "🐟🌊"
           exit
         end
      end
    end
   end

   def human_lose
     all_sunk =  @human_board.cells.values.count do |cell|
       if cell.ship != nil
         cell.ship.sunk?
       end
       end
       if all_sunk == 5
         human_lose_message
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
    #smashed together word edcgecase -- a1a2a3
  end

  def human_place_sub
    submarine = Ship.new("Submarine", 2)
    loop do
      input = gets.chomp.tr(',', ' ').upcase.strip
       sub_cords = input.split
       if @human_board.valid_placement?(submarine, sub_cords)
         @human_board.place(submarine, sub_cords)
         break
         break
       else
         puts "Not a valid placement."
         puts "Enter the squares for the submarine(2 spaces):"
       end
     end
  end

  def human_shot
    puts "Enter coordinates to fire upon, mon Capitan!"
    loop do
      firing_coords = gets.chomp.tr(',', ' ').upcase.strip
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
