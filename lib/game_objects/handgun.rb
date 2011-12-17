require "chingu"

class Handgun < Chingu::GameObject
  attr_accessor :player

  def initialize(options = {})
    super(options.merge(image: 'handgun.png', zorder: 310))
    @player = options[:player]
  end

  def update
    super
    self.x = @player.x
    self.y = @player.y
    self.angle = @player.angle
  end
end
