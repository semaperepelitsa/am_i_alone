require "chingu"
require "handgun"

class Zombi < Chingu::GameObject
  traits :velocity, :timer
  SPEED = 3

  attr_accessor :target

  def initialize(options = {})
    super(options.merge(image: 'zombi.png', zorder: 200))

    self.target = options[:target]
    @lag = 1000
    remember_target_pos
    every(@lag) { remember_target_pos }
    @game_area = options.fetch(:game_area)
  end

  def remember_target_pos
    @target_x = target.x
    @target_y = target.y
  end

  def update
    super

    # FUCKING MATH
    dx = @target_x - x
    dy = @target_y - y
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

  def angle_rad
    @angle = value / 180 * Math::PI
  end
end
