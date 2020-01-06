class Board
  attr_accessor :state

  def initialize
    @state = create_board
  end

  def create_board
    board = Array.new(7) { Array.new(6, "| \u{2610} ") }
  end
  
  def insert_disc(disc, column)
    row = 0
    
    loop do
      unless state[column][row].is_a? Disc
        disc.column = column
        disc.row = row
        state[column][row] = disc
        break
      end
      row += 1
    end
    [column, row] #maybe delete
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
    state.each_with_index { |column, i| print "| #{i + 1} " }
    print "|"
    2.times { puts "" }
  end

  def four_in_row?(disc)
    return true if horizontal_match?(disc)
    return true if vertical_match?(disc)
    return true if diagonal_down_match?(disc)
    return true if diagonal_up_match?(disc)
    false
  end

  def diagonal_down_match?(disc)
    current = disc
    
    column = disc.column
    row = disc.row

    while column > 0 && row < state[0].size - 1
      current = state[column - 1][row + 1]

      column -= 1
      row += 1
    end

    counter = 0

    loop do
      if current.is_a? Disc
        current.color == disc.color ? counter += 1 : counter = 0
      else
        current = 0
      end

      return true if counter >= 4
      break if column == state.size - 1
      break if row == 0

      current = state[column + 1][row - 1]
      column += 1
      row -= 1
    end
    false
  end

  def diagonal_up_match?(disc)
    current = disc
    
    column = disc.column
    row = disc.row

    while column > 0 && row > 0
      current = state[column - 1][row - 1]

      column -= 1
      row -= 1
    end

    counter = 0

    loop do
      if current.is_a? Disc
        current.color == disc.color ? counter += 1 : counter = 0
      else
        current = 0
      end

      return true if counter >= 4
      break if column == state.size - 1
      break if row == state[0].size

      current = state[column + 1][row + 1]
      column += 1
      row += 1
    end
    false
  end

  def vertical_match?(disc)
    counter = 0

    state[disc.column].each do |row|
      if row.is_a? Disc
        row.color == disc.color ? counter += 1 : counter = 0
      end
      return true if counter >= 4
    end
    false
  end

  def horizontal_match?(disc)
    counter = 0

    state.each do |column|
      if column[disc.row].is_a? Disc
        column[disc.row].color == disc.color ? counter += 1 : counter = 0
        return true if counter >= 4
      else
        counter = 0
      end
    end
    false
  end

  def column_full?(column)
    return true if state[column].all? { |spot| spot.is_a? Disc }
    false
  end
end



#current = nil
#if disc.column - disc.row < 0
#  current = state[0][(disc.column - disc.row).abs]
#else
#  current = state[disc.column - disc.row][0]
#end
##Add tile classes with columns and rows
#counter = 0
#row = 0
#column = current.column
#
#until row >= state[0].size
#  if current.is_a? Disc
#    current.color == disc.color ? counter += 1 : counter = 0
#  else
#    counter = 0
#  end
#  break if state[column + 1].nil?
#  current = state[column + 1][row + 1] if state[column + 1][row + 1]
#  row += 1
#  column += 1
#end
#return true if counter >= 4
#false