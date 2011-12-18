require "chingu"
require "handgun"

class Zombi < Chingu::GameObject
  traits :velocity, :timer, :bounding_circle, :collision_detection
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

    @hp = options[:hp] || 1
    @ending_angle = angle
  end

  def remember_target_pos
    @target_x = target.x
    @target_y = target.y
  end

  def update
    super

    unless @dying
      if turn Gosu.angle(x, y, target_x, target_y)
        self.velocity_x = 0
        self.velocity_y = 0
      else
        self.velocity_x = SPEED * Math.sin(angle_rad)
        self.velocity_y = - SPEED * Math.cos(angle_rad)
      end
    end

    self.y = @game_area.top    if self.y < @game_area.top
    self.y = @game_area.bottom if self.y > @game_area.bottom

    self.x = @game_area.left   if self.x < @game_area.left
    self.x = @game_area.right  if self.x > @game_area.right
  end

  def angle_rad=(value)
    self.angle = value * 180 / Math::PI
  end

  def angle_rad
    angle / 180 * Math::PI
  end

  def turn(ending_angle = nil)
    @ending_angle = ending_angle if ending_angle
    step = 1
    diff = Gosu.angle_diff(angle, @ending_angle)
    if diff.abs < 1
      self.angle = @ending_angle
      nil
    elsif diff > 0
      self.angle += step
      step
    else
      self.angle -= step
      step
    end
  end

  def hit_by(bullet)
    @hp -= bullet.damage
    if @hp <= 0
      die
    end
  end

  def die
    @dying = true
    self.collidable = false
    self.velocity_y = 0
    self.velocity_x = 0
    @color = Gosu::Color::RED.dup
    between(1,1000) { self.velocity_y = 0; self.alpha -= 2; }.then{ destroy }
  end
end
