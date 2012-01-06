require "chingu"

class HelpBar < Chingu::GameObject
  trait :timer

  def initialize(opts={})
    super
    @color = Gosu::Color::WHITE.dup
    @font = Gosu::Font[24]
    @text = "W A S D to move, mouse to point and shoot"
  end

  def setup
    after(3000){ dismiss }
  end

  def draw
    @font.draw_rel @text, $window.width/2, $window.height - 10, 9900, 0.5, 1.0, 1, 1, @color
  end

  def dismiss
    @dismissing = true
  end

  def update
    if @dismissing
      if @color.alpha > 0
        @color.alpha -= 3
      else
        destroy
      end
    end
  end

end
