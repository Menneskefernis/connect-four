require 'colorize'
require_relative 'player'
require_relative 'board'
require_relative 'disc'

class Game
  attr_reader :player1, :player2
  
  def initialize
    @player1 = Player.new("\u{26d4}".red)
    @player2 = Player.new("\u{26d4}".green)
  end
end


#puts "\u{26d4}"

board = Board.new
disc1 = Disc.new("X")

board.insert_disc(disc1, 5 - 1)
board.draw