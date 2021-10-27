class CellCreator
  attr_reader :custom_cells
  def initialize
    @board_cells = Hash.new
  end

  def cells
  rows = ['A','B','C','D']
  columns = [1,2,3,4]
  grid = rows.product(columns)
  grid = grid.map do |square|
    square.join
  end
  grid.each do |cell|
    @board_cells[cell] = Cell.new(cell)
  end
    @board_cells
  end
end
