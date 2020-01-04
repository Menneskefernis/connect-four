class Board
  attr_accessor :state

  def initialize
    @state = create_board
  end

  def create_board
    board = Array.new(7) { Array.new(6, "| - ") }
  end
  
  def insert_disc(disc, column)
    state[column][0] = disc
  end

  def draw
    
    puts ""
    (state[0].size - 1).downto(0) do |i|
      #10.times { print " " }
      state.each do |column|
        print column[i]
      end
      print "|\n"
    end
    29.times { print "-" }
    puts ""
    state.each_with_index { |column, i| print "| #{i} " }
    print "|"
    2.times { puts "" }
  end
end
  
#board = Board.new
#board.draw