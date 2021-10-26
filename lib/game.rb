
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
  end

  def welcome_message
    system "clear"
    sleep(3)
     puts "Welcome to BATTLESHIP \n" +
     "Enter p to play. Enter q to quit."
     player_input = gets.chomp.downcase.strip
     until ["p","q"].include?(player_input)
       puts "Invalid input. Try again!"
       player_input = gets.chomp.downcase.strip
     end
    if player_input == "p"
        @cpu_player.cpu_generate_cruiser
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
     puts "Enter a ship with a length 4 or fewer spaces."
     @human_player.human_place_ship
     puts "You put your ship down. This is your board: \n #{@human_board.render(true)}"
     sleep(3)
     puts "You now need to lay out your second ship."
     puts "Enter a ship with a length 4 or fewer spaces."
     @human_player.human_place_ship
     puts "You put your ship down. This is your board: \n #{@human_board.render(true)}"
     system "clear"
     puts "Prepare to be battle!!!"
     sleep(3)
     system "clear"
     game_body
   end

   def game_body
     until @human_player.human_lose? || @cpu_player.cpu_lose?
       puts "=============COMPUTER BOARD============= \n"
       puts "#{@cpu_board.render(true)}\n"
       cpu_shot
       puts "==============PLAYER BOARD=============="
       puts "#{@human_board.render(true)}"
       human_shot
      end
      if @human_player.human_lose?
        human_lose_message
      elsif
        @cpu_player.cpu_lose?
        human_win_message
      end
   end

   def human_win_message
     puts @cpu_board.render
     puts "ENEMY FLEET ELIMINATED"
     sleep(2)
     puts "You win this time, Captain! Would you like to play again?"
     puts "Press P to play again, Q to quit."
     player_input = gets.chomp.downcase.strip
     until ["p","q"].include?(player_input)
       puts "Invalid input. Try again!"
       player_input = gets.chomp.downcase.strip
     end
    if player_input == "p"
      clear_board
      welcome_message
    elsif player_input == "q"
      system "clear"
      puts "\e[34m#{"Sleep with da fishes!!!"}\e[0m"
      sleep(2)
      1000.times do
        print "🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊"
      end
       exit
     end
   end


   def human_lose_message
     puts @cpu_board.render(true)
     puts "PLAYER FLEET ELIMINATED"
     puts "You lose, Captain! Would you like to play again?"
     puts "Press P to play again, Q to quit."
     player_input = gets.chomp.downcase.strip
     until ["p","q"].include?(player_input)
       puts "Invalid input. Try again!"
       player_input = gets.chomp.downcase.strip
     end
    if player_input == "p"
      clear_board
      welcome_message
    elsif player_input == "q"
      system "clear"
      puts "\e[34m#{"Sleep with da fishes!!!"}\e[0m"
      sleep(2)
      1000.times do
        print "🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊🐟🌊"
      end
       exit
     end
   end

   def clear_board
     @human_board = Board.new
     @human_player = HumanPlayer.new
     @cpu_player  = CpuPlayer.new
     @cpu_board   = cpu_player.cpu_board
     @human_board = human_player.human_board
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
       puts "I sunk your ship #{human_board.cells[firing_coords].ship.name}!"
     end
   end

  def human_shot
    puts "Enter coordinates to fire upon, mon Capitan!"
      firing_coords = gets.chomp.tr(',', ' ').upcase.strip
      if @cpu_board.valid_coordinate?(firing_coords) && @cpu_board.cells[firing_coords].fired_upon? == false
        @cpu_board.cells[firing_coords].fire_upon
          if @cpu_board.cells[firing_coords].fired_upon? && @cpu_board.cells[firing_coords].empty?
            puts "Shot was a miss!"
          elsif @cpu_board.cells[firing_coords].fired_upon? && @cpu_board.cells[firing_coords].ship.sunk? == false && @cpu_board.cells[firing_coords].empty? == false
            puts "Hit on #{@cpu_board.cells[firing_coords].coordinate}!"
          elsif @cpu_board.cells[firing_coords].ship.sunk?
            puts "You sunk the cpu's ship the #{@cpu_board.cells[firing_coords].ship.name}!"
          end
        elsif @cpu_board.valid_coordinate?(firing_coords) == false
          puts "That coordinate does not exist on the board."
          puts "try again"
        elsif @cpu_board.cells[firing_coords].fired_upon? == true
          puts "You've already fired on #{@cpu_board.cells[firing_coords].coordinate}. Try again!"
          human_shot
      end
    end
  end



