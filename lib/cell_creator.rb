class CellCreator
  def initialize
    @board_cells = Hash.new
  end

  def cells
  rows = ('A'..'D').to_a
  columns = ('1'..'4').to_a
  grid = rows.product(columns)
  grid = grid.map do |square|
    square.join
  end
  grid.each do |x|
    @board_cells[x] = Cell.new(x)
  end
    @board_cells
  end
end