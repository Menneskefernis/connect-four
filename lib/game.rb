require 'colorize'
require_relative 'player'
require_relative 'board'
require_relative 'disc'

class Game
  def start
    intro
    play_round until game_end
  end

  private
  attr_reader :player1, :player2, :board
  attr_accessor :current_player, :game_end
  
  def initialize
    @board = Board.new
    @player1 = Player.new("\u{26AB}".red)
    @player2 = Player.new("\u{26AB}".green)
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

  def play_round
    board.draw
    choice = get_input
    
    new_disc = Disc.new(current_player.color)
    board.insert_disc(new_disc, choice - 1)
    end_game if board.four_in_row?(new_disc) || board.full?

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

  def end_game
    board.draw

    if board.full?
      puts "The game ended in a tie. Congratulations, you are equally bad!\n\n"
    else
      player = current_player == player1 ? "Red" : "Green"
      puts "#{player}".upcase + " #{current_player}" + "won the game!\n\n".upcase
    end
    self.game_end = true
  end
end

game = Game.new
game.start