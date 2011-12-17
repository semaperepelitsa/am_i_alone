require "chingu"
require "gun"

class Player < Chingu::GameObject
  traits :velocity
  SPEED = 3

  attr_accessor :weapon

  def initialize(options = {})
    super(options.merge(image: 'player.png', zorder: 300))
    self.input = [ :holding_left,
                   :holding_right,
                   :holding_up,
                   :holding_down ]

    self.weapon = Gun.create(player: self)
  end

  def update
    super

    # FUCKING MATH
    dx = $window.mouse_x - x
    dy = $window.mouse_y - y
    self.angle_rad = Math.acos( dx / Math.hypot(dx, dy) )
    self.angle = 360 - angle if dy < 0
  end

  def angle_rad=(value)
    @angle = value * 180 / Math::PI
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
