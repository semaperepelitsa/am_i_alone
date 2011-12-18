require "chingu"
require "handgun"

class Player < Chingu::GameObject
  traits :velocity
  SPEED = 3

  attr_accessor :cursor
  attr_reader :weapon

  def initialize(options = {})
    super(options.merge(image: 'player.png', zorder: 300))
    self.input = { :holding_a => :move_left,
                   :holding_d => :move_right,
                   :holding_w => :move_up,
                   :holding_s => :move_down }

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

    self.angle = Gosu.angle(x, y, @cursor.x, @cursor.y)

    self.y = @game_area.top    if self.y < @game_area.top
    self.y = @game_area.bottom if self.y > @game_area.bottom

    self.x = @game_area.left   if self.x < @game_area.left
    self.x = @game_area.right  if self.x > @game_area.right
  end

  def angle_rad=(value)
    @angle = value * 180 / Math::PI
  end

  def move_left
    move(-SPEED, 0)
  end

  def move_right
    move(SPEED, 0)
  end

  def move_up
    move(0, -SPEED)
  end

  def move_down
    move(0, SPEED)
  end
end
