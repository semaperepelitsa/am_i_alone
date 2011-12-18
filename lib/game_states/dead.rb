require "chingu"
require "play"

class Dead < Chingu::GameState
  attr_accessor :score

  def initialize(options = {})
    super
    @score = options[:score]
    self.input = { [:enter, :return, :escape] => :restart }
  end

  def restart
    switch_game_state(Play)
  end

  def setup
    @font = Gosu::Font[35]
  end

  def draw
    super
    @font.draw_rel("You've killed #{score} zombies", $window.width/2, $window.height/2, 9990, 0.5, 1.0)
    @font.draw_rel(score.description, $window.width/2, $window.height/2, 9990, 0.5, 0.0)
  end
end
