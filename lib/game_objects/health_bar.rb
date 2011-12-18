require "chingu"

class HealthBar < Chingu::BasicGameObject
  def initialize(options = {})
    super
    @image = Gosu::Image['heart.png']
    @victim = options[:victim]

    @margin_x = 10
    @margin_y = 20
    @space = 5
  end

  def hp
    @victim.hp
  end

  def draw
    hp.times do |i|
      @image.draw(
        @margin_x + (@image.width + @space) * i,
        @margin_y, 9900
      )
    end
  end
end
