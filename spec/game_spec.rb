require './lib/game'

describe Game do
  let(:game) { Game.new }
  
  describe "#initialize" do
    it "sets a color for player 1" do
      expect(game.player1.color).to eql("\e[0;31;49m⚫\e[0m")
    end
  end

  describe "#switch_player" do
    it "switches the active player from Player 1 to Player 2" do
      game.current_player = game.player1
      game.switch_player
      expect(game.current_player).to eql(game.player2)
    end
  end

  describe "#switch_player" do
    it "switches the active player from Player 2 to Player 1" do
      game.current_player = game.player2
      game.switch_player
      expect(game.current_player).to eql(game.player1)
    end
  end

  describe "validate that the user input is one of the given choices" do
    it "accepts and returns an integer from 1 - 7" do
      game.stub(:gets) { "1" }
      expect(game.get_input).to eq(1)
    end
  end
end