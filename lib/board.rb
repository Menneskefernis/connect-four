class Board
  attr_accessor :state

  def initialize
    @state = create_board
  end

  def create_board
    Array.new(7) { Array.new(6) }
  end
  
  def draw
    puts 7.times { print "|   " }
    puts 7.times { print "|   " }
    puts 7.times { print "|   " }
    puts 7.times { print "|   " }
    puts 7.times { print "|   " }
    puts 7.times { print "|   " }
  end
end
  
#board = Board.new
#board.draw