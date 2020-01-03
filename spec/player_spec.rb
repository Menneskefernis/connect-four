require './lib/player'

describe Player do
  describe "#initialize" do
    it "sets a given marker for a player" do
      player = Player.new("X")
      expect(player.marker).to eql("X")
    end
  end
end