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
    # p $window.mouse_x, $window.mouse_y
    self.angle = 30
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
