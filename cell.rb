# Initialize a Cell width alive as false by default
class Cell
  attr_accessor :alive, :x, :y

  def initialize(x=0, y=0)
    @alive = false
    @x = x
    @y = y
  end

  def alive?; alive; end
  def dead?; !alive; end

  # kill the cell
  def die!
    @alive = false
  end
  
  # revive the cell
  def revive!
    @alive = true
  end
end