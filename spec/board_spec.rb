require './lib/board'

describe Board do
  game_board = Board.new
  game_board.create_board
  
  describe "#create_board" do
    it "sets up the board with nested 7 arrays" do
      expect(game_board.state.size).to eql(7)
    end

    #it "sets the nested arrays with size 6" do
    #  expect(game_board.state[0].size).to eql(6)
    #end
  end

  describe "#insert_disc" do
    it "adds a disc to a column on the board" do
      disc = Disc.new("X")
      game_board.insert_disc(disc, 4)
      expect(game_board.state[4][0]).to eql(disc)
    end
  end
end