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
        cpu_generate_cruiser && cpu_generate_sub
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
     puts "You put the ship down. This is your board: \n #{@human_board.render(true)}"
     puts "Enter the squares for the submarine(2 spaces):"
     human_place_sub
     puts "You put the ship down. This is your board: \n #{@human_board.render(true)}"
     sleep(3)
     system "clear"
     game_body
   end

   def game_body
     require "pry"; binding.pry

     5.times do
       puts "=============COMPUTER BOARD============= \n"
       puts "#{@cpu_board.render}\n"
       cpu_shot
       puts "==============PLAYER BOARD=============="
       puts "#{@human_board.render(true)}"
       human_shot
      end
   end

   def cpu_lose

     @cpu_board.cells.ship.all.sunk?
     puts "CPU Loses!"
   end

   def player_lose
   end


   # def game_end
   # end

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
            puts "You sunk my boat!"
          end
        break
      else
        puts "That coordinate does not exist on the board."
        puts "try again"
      end
    end
  end



  def cpu_generate_cruiser
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
  end

    def cpu_generate_sub
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
    end #e to computer class?
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

end



