require './lib/board'

describe Board do
  describe "#create_board" do
    it "sets up the board with nested 7 arrays" do
      game_board = Board.new
      game_board.create_board
      expect(game_board.state.size).to eql(7)
    end

    it "sets the nested arrays with size 6" do
      game_board = Board.new
      game_board.create_board
      expect(game_board.state[0].size).to eql(6)
    end
  end
end