class CpuPlayer
  attr_reader :cpu_board
  def initialize
    @cpu_board = Board.new
  end

  def cpu_lose?
    # refactor note: ship != nill count
    # compare ship !nil against cell.sunk?
    # if count matches for both, all sunk.
    all_sunk = @cpu_board.cells.values.count do |cell|
         if cell.ship != nil
             cell.ship.sunk?
           end
         end
     if all_sunk == 5
       return true
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
    end
  end
end
