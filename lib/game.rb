
class Game
  attr_reader :human_board,
              :cpu_board,
              :cruiser_cords,
              :cpu_player,
              :human_player
  def initialize
    @human_player = HumanPlayer.new
    @cpu_player   = CpuPlayer.new
    @cpu_board    = cpu_player.cpu_board
    @human_board  = human_player.human_board
    @unshot_cords = @human_board.cells.keys
    @player_name  = nil
  end

  def welcome_message
    system "clear"
    sleep(3)
    puts "Welcome to BATTLESHIP \n" +
    "Enter P to play. Enter Q to quit."

    player_input = gets.chomp.downcase.strip

    until ["p","q"].include?(player_input)
      puts "Invalid input. Try again!"
    end

    if player_input == "p"
      @cpu_player.cpu_generate_cruiser
      game_setup
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

  def game_setup
     system "clear"
     print "Enter your name: "
     @player_name = gets.chomp.strip
     system "clear"
     sleep(1)
     puts "Greetings, captain #{@player_name}."
     sleep(1)
     puts "I have laid out my ships on the grid."
     sleep(1)
     puts "You now need to lay out your two ships."
     @human_player.human_place_ship
     puts "You put your ship down. This is your board: \n #{@human_board.render(true)}"
     sleep(2)
     puts "You now need to lay out your second ship."
     @human_player.human_place_ship
     puts "You put your ship down. This is your board: \n #{@human_board.render(true)}"
     sleep(2)
     system "clear"
     puts "Prepare to battle!!!"
     sleep(3)
     system "clear"
     game_body
   end

  def game_body
    until @human_player.human_lose? || @cpu_player.cpu_lose?
      puts  "\e[36m#{"=============COMPUTER BOARD============= \n"}\e[0m"
      puts "#{@cpu_board.render}\n"
      cpu_shot

      if @human_player.human_lose?
        human_lose_message
      end
      puts "\e[32m#{"==============PLAYER BOARD=============="}\e[0m"
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
     puts "You win this time, Captain #{@player_name}! Would you like to play again?"
     puts "Press P to play again, Q to quit"
     player_input = gets.chomp.downcase.strip
     until ["p","q"].include?(player_input)
       puts "Invalid input. Try again!"
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
     sleep(2)
     puts @cpu_board.render(true)
     puts "PLAYER FLEET ELIMINATED"
     puts "You lose, Captain #{@player_name}! Would you like to play again?"
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
      sleep(1)
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
     firing_coords = @unshot_cords.sample
     @unshot_cords.delete(firing_coords)
     @human_board.cells[firing_coords].fire_upon
     if @human_board.cells[firing_coords].fired_upon? && @human_board.cells[firing_coords].empty?
       puts "Shot was a miss on #{firing_coords}!"
     elsif @human_board.cells[firing_coords].fired_upon? && @human_board.cells[firing_coords].ship.sunk? == false && @human_board.cells[firing_coords].empty? == false
       puts "Hit on #{firing_coords}! Ouch!"
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
            puts "Shot was a miss on #{firing_coords}!"
          elsif @cpu_board.cells[firing_coords].fired_upon? && @cpu_board.cells[firing_coords].ship.sunk? == false && @cpu_board.cells[firing_coords].empty? == false
            puts "Hit on #{firing_coords}!"
          elsif @cpu_board.cells[firing_coords].ship.sunk?
            puts "You sunk the cpu's ship The #{@cpu_board.cells[firing_coords].ship.name} with your hit on #{firing_coords}!"
          end
        elsif @cpu_board.valid_coordinate?(firing_coords) == false
          puts "That coordinate is out of range! Fire again!"
          human_shot
        elsif @cpu_board.cells[firing_coords].fired_upon? == true
          puts "You've already fired on #{@cpu_board.cells[firing_coords].coordinate}. Try again!"
          human_shot
      end
    end
  end
