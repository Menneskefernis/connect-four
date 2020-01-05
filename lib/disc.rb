class Disc
  attr_accessor :color #should be changed to reader
  attr_accessor :column, :row
  #:belongs_to
  def initialize(color)
    @color = color
    @column = nil
    @row = nil
    #@belongs_to = belongs_to
  end

  def to_s
    "| #{color} "
  end
end