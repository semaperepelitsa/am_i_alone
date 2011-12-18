require "chingu"

class ScoreBar < Chingu::BasicGameObject
  attr_accessor :score

  def initialize(options = {})
    super
    @score = options[:score]

    @x = $window.width  - 20
    @y = $window.height - 20
    @zorder = 9000

    @font = Gosu::Font[35]
  end

  def draw
    @font.draw_rel(score, @x, @y, 9900, 1.0, 1.0)
    @font.draw_rel(score.description, @x, @y - 40, 9900, 1.0, 1.0)
  end
end
