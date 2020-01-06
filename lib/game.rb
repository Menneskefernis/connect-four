require 'colorize'
require_relative 'player'
require_relative 'board'
require_relative 'disc'

class Game
  attr_accessor :player1, :player2, :board #should be made reader
  attr_accessor :current_player, :game_end
  #\u{26AB}
  def initialize
    @board = Board.new
    @player1 = Player.new("X".red)
    @player2 = Player.new("O".green)
    @current_player = player1
    @game_end = false
  end

  def intro
    puts ""
    puts "Welcome to " + "Connect Four".green + "!"
    puts ""
    puts "Pick a color, " + "\u{26d4}".red + " or " + "\u{26d4}".green
    puts "\u{26d4}".red + " starts."
    puts ""
  end

  def start
    intro
    play_round until game_end
  end

  def play_round
    board.draw
    choice = get_input
    
    new_disc = Disc.new(current_player.color)
    board.insert_disc(new_disc, choice - 1)
    self.game_end = true if board.four_in_row?(new_disc)
    
    switch_player
  end

  def get_input
    input = ""
    loop do
      puts "Where would you like to place your Disc, #{current_player}?"
      input = gets.chomp.to_i

      if (1..7).include? input
        column_full = board.column_full?(input - 1)
        puts "\nColumn is full. Please pick another.".red if column_full
        break unless column_full
      end
      
      puts "\nPlease select a valid number from 1 to 7!"
    end
    input
  end

  def switch_player
    if current_player == player1
      self.current_player = player2
    else
      self.current_player = player1
    end
  end
end



#game_board = Board.new
#        
#disc1_0 = Disc.new("O")
#disc2_0 = Disc.new("X") 
#disc1_1 = Disc.new("O")
#disc2_1 = Disc.new("X")
#disc3_0 = Disc.new("X")
#disc1_2 = Disc.new("O")
#disc4_0 = Disc.new("X")
#disc3_1 = Disc.new("X")
#disc2_2 = Disc.new("X")
#disc1_3 = Disc.new("O")
#
##game_board.insert_disc(disc1_0, 3)
#game_board.insert_disc(disc2_0, 1)
#game_board.insert_disc(disc1_1, 1)
#game_board.insert_disc(disc2_1, 1)
#game_board.insert_disc(disc3_0, 1)
#game_board.insert_disc(disc1_2, 1)
#game_board.insert_disc(disc4_0, 1)
#game_board.insert_disc(disc3_1, 6)
#game_board.insert_disc(disc2_2, 6)
#game_board.insert_disc(disc1_3, 6)
#
#puts game_board.diagonal_down_match?(disc3_1)
#game_board.draw

game = Game.new
game.start