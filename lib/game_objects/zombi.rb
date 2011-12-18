require "chingu"
require "handgun"

class Zombi < Chingu::GameObject
  traits :velocity, :timer
  SPEED = 2

  attr_reader :target_x, :target_y
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

    self.angle = Gosu.angle(x, y, target_x, target_y)

    self.velocity_x = SPEED * Math.sin(angle_rad)
    self.velocity_y = - SPEED * Math.cos(angle_rad)

    self.y = @game_area.top    if self.y < @game_area.top
    self.y = @game_area.bottom if self.y > @game_area.bottom

    self.x = @game_area.left   if self.x < @game_area.left
    self.x = @game_area.right  if self.x > @game_area.right
  end

  def angle_rad=(value)
    @angle = value * 180 / Math::PI
  end

  def angle_rad
    angle / 180 * Math::PI
  end
end
