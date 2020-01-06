class EmptySlot
  attr_accessor :column, :row
  def initialize(column, row)
    @column = column
    @row = row
  end

  def to_s
    "| \u{26AA}"
  end
end