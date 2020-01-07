class Player
  attr_reader :color
  
  def initialize(color)
    @color = color
  end
  
  private
  def to_s
    color
  end
end