require './lib/player'

describe Player do
  describe "#initialize" do
    it "sets a given color for a player" do
      player = Player.new("X")
      expect(player.color).to eql("X")
    end
  end
end