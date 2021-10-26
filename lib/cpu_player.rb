class CpuPlayer
  attr_reader :cpu_board
  def initialize
    @cpu_board = Board.new
  end

  def cpu_lose?
    all_sunk = @cpu_board.cells.values.count do |cell|
      cell.ship != nil && cell.ship.sunk?
      end
    all_placed_not_yet_sunk = @cpu_board.cells.values.count do |cell|
        cell.ship
      end
    if all_sunk == all_placed_not_yet_sunk
       return true
     end
  end

  def cpu_generate_cruiser
    2.times do
    cruiser_names = ['Yamoto', 'Yorktown', 'Enterprise', 'Hornet', 'Lexington', 'Bismarck', 'Jolly Rancher']
    cruiser_lengths =[1,2,3,4]
    cruiser_name = cruiser_names.sample
    cruiser_length = cruiser_lengths.sample
    cpu_cruiser = Ship.new(cruiser_name, cruiser_length)
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
  end

  # def cpu_generate_sub
  #   cpu_sub = Ship.new("Submarine", 2)
  #   loop do
  #     sub_cords = []
  #     until sub_cords.length == cpu_sub.length do
  #       sub_cords << @cpu_board.cells.keys.sample
  #     end
  #     if @cpu_board.valid_placement?(cpu_sub, sub_cords)
  #       @cpu_board.place(cpu_sub, sub_cords)
  #       break
  #     end
  #   end
  # end
end
