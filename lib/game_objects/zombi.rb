require "chingu"
require "handgun"

class Zombi < Chingu::GameObject
  traits :velocity, :timer, :bounding_circle, :collision_detection
  SPEED = 2

  attr_accessor :target
  attr_reader :damage

  def initialize(options = {})
    super(options.merge(image: 'zombi.png', zorder: 200))

    self.target = options[:target]
    @game_area = options.fetch(:game_area)

    @hp = options[:hp] || 1
    @damage = options[:damage] || 1
  end

  def update
    super

    unless @dying
      self.angle = Gosu.angle(x, y, target.x, target.y)

      cached_angle_rad = angle_rad
      self.velocity_x = SPEED * Math.sin(cached_angle_rad)
      self.velocity_y = - SPEED * Math.cos(cached_angle_rad)

      each_collision(Player) do |zombi, player|
        player.hit_by(zombi)
      end
    end

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
    @target.killed(self)
    @color = Gosu::Color::RED.dup
    between(1,1000) { self.velocity_y = 0; self.alpha -= 2; }.then{ destroy }
  end
end
