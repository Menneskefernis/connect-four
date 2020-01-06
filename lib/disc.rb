class Disc
  attr_accessor :color #should be changed to reader
  attr_accessor :column, :row

  def initialize(color)
    @color = color
    @column = nil
    @row = nil
  end

  def to_s
    "| #{color}"
  end
end