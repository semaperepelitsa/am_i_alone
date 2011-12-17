require "chingu"

class Gun < Chingu::GameObject
  def initialize(options = {})
    super(options.merge(image: 'gun.png', zorder: 310))
    @player = options.fetch(:player)
  end

  def update
    super
    self.x = @player.x
    self.y = @player.y
    self.angle = @player.angle
  end
end
