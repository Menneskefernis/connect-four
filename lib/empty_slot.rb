class EmptySlot
  attr_reader :column, :row

  private
  def initialize(column, row)
    @column = column
    @row = row
  end

  def to_s
    "| \u{26AA}"
  end
end