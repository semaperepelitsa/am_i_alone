require "chingu"
require "handgun"

class Player < Chingu::GameObject
  traits :velocity
  SPEED = 3

  attr_accessor :cursor
  attr_reader :weapon

  def initialize(options = {})
    super(options.merge(image: 'player.png', zorder: 300))
    self.input = [ :holding_left,
                   :holding_right,
                   :holding_up,
                   :holding_down ]

    self.cursor = options.fetch(:cursor)
    self.weapon = options[:weapon]
    @game_area = options.fetch(:game_area)
  end

  def weapon=(new_weapon)
    @weapon = new_weapon
    @weapon.player = self
  end

  def update
    super

    # FUCKING MATH
    dx = @cursor.x - x
    dy = @cursor.y - y
    self.angle_rad = Math.acos( dx / Math.hypot(dx, dy) )
    self.angle = 360 - angle if dy < 0

    self.y = @game_area.top    if self.y < @game_area.top
    self.y = @game_area.bottom if self.y > @game_area.bottom

    self.x = @game_area.left   if self.x < @game_area.left
    self.x = @game_area.right  if self.x > @game_area.right
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
