class Disc
  attr_accessor :column, :row
  attr_reader :color

  private
  def initialize(color)
    @color = color
    @column = nil
    @row = nil
  end

  def to_s
    "| #{color}"
  end
end