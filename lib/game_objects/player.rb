require "chingu"

class Player < Chingu::GameObject
  traits :velocity
  SPEED = 3

  def initialize(options = {})
    super(options.merge(image: 'player.png'))
    self.input = [ :holding_left,
                   :holding_right,
                   :holding_up,
                   :holding_down ]
  end

  def holding_left
    move(-SPEED, 0)
  end

  def holding_right
    move(SPEED, 0)
  end

  def holding_up
    move(0, -SPEED)
  end

  def holding_down
    move(0, SPEED)
  end
end
