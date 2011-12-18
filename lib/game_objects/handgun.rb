require "chingu"
require "bullet"

class Handgun < Chingu::GameObject
  attr_accessor :player

  def initialize(options = {})
    super(options.merge(image: 'handgun.png', zorder: 310))
    @player = options[:player]
    self.input = { [:space, :mouse_left] => :fire }
  end

  def update
    super
    self.x = @player.x
    self.y = @player.y
    self.angle = @player.angle
  end

  def fire
    Bullet.create(weapon: self)
  end
end
