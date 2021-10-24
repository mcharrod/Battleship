require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'

RSpec.describe Game do

  it "exists" do
    board = Board.new
    human_board = Board.new
    cpu_board = Board.new
    game = Game.new
    expect(game).to be_a(Game)
  end

  # it 'board' do
  #   human_board = Board.new
  #   cpu_board = Board.new
  #   game = Game.new(human_board, cpu_board)
  #   expect(game.human_board).to be_a(Board)
  #   expect(game.cpu_board).to be_a(Board)
  #   cruiser = Ship.new("MemeCruiser", 3)
  #   human_board.place(cruiser, ["A1", "A2", "A3"])
  # end


    it 'boards' do
      game = Game.new
      expect(game.human_board).to be_a(Board)
      expect(game.cpu_board).to be_a(Board)
    end

    xit "welcome_message" do
      game = Game.new
      expect game.welcome_message
      #not sure about testing yet, requires input
    end

    # xit "cpu_generate_ships" do
    #   game = Game.new
    #   expect(game.cpu_generate_ships.count).to eq(2)
    # end

    it 'prompts user to place ships' do
      game = Game.new
      human_board = Board.new
      cpu_board = Board.new
      prompt = "\nI have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the\nSubmarine is two units long."
      puts game.user_place_ships
      expect(game.user_place_ships).to eq(human_board.render)
      # expect(game.user_place_ships).to eq($stdin.gets.chomp)
    end

    xit 'places valid placements' do
     allow($stdin).to receive(:gets) { board }
    end
  end
