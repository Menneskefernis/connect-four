require 'colorize'
require 'player'
require 'board'

class Game
  attr_reader :player1, :player2
  
  def initialize
    @player1 = Player.new("\u{26d4}".red)
    @player2 = Player.new("\u{26d4}".green)
  end
end


#puts "\u{26d4}"