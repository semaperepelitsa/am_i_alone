require "chingu"

class Bullet < Chingu::GameObject
  trait :velocity
  SPEED = 30

  def initialize(options = {})
    super({ image: 'bullet.png', zorder: 150 }.merge(options))
    @weapon = options.fetch(:weapon)
    @x, @y, @angle = @weapon.x, @weapon.y, @weapon.angle

    self.velocity_x = SPEED * Math.sin(angle_rad)
    self.velocity_y = - SPEED * Math.cos(angle_rad)
  end

  def angle_rad
    angle / 180 * Math::PI
  end
end
