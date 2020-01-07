require_relative 'empty_slot'

class Board
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
  end

  def draw
    puts ""
    (state[0].size - 1).downto(0) do |i|
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

  def column_full?(column)
    return true if state[column].all? { |spot| spot.is_a? Disc }
    false
  end

  def full?
    state.each do |column|
      return false if column.any? { |slot| slot.is_a? EmptySlot }
    end
    true
  end

  private
  attr_accessor :state

  def initialize
    @state = create_board
  end

  def create_board
    board = Array.new(7) { Array.new(6) }
    add_empty_slots(board)
  end
  
  def add_empty_slots(array)
    array.map.each_with_index do |column, i|
      column.map.each_with_index do |row, j|
        row = EmptySlot.new(i, j)
      end
    end
  end

  def diagonal_down_match?(disc)
    current = disc
    
    #rewind to first slot in diagonal row
    while current.column > 0 && current.row < state[0].size - 1
      current = state[current.column - 1][current.row + 1]
    end

    counter = 0

    loop do
      if current.is_a? Disc
        current.color == disc.color ? counter += 1 : counter = 0
      else
        counter = 0
      end
      return true if counter >= 4
      break if current.column == state.size - 1
      break if current.row == 0
      current = state[current.column + 1][current.row - 1]
    end
    false
  end

  def diagonal_up_match?(disc)
    current = disc
    
    #rewind to first slot in diagonal row
    while current.column > 0 && current.row > 0
      current = state[current.column - 1][current.row - 1]
    end

    counter = 0

    loop do
      if current.is_a? Disc
        current.color == disc.color ? counter += 1 : counter = 0
      else
        counter = 0
      end
      return true if counter >= 4
      break if current.column == state.size - 1
      break if current.row == state[0].size - 1
      current = state[current.column + 1][current.row + 1]
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
end