# encoding: UTF-8
require "chingu"
require "play"

class Dead < Chingu::GameState
  attr_accessor :score

  def initialize(options = {})
    super
    @score = options[:score]
    self.input = { [:enter, :return] => :restart }
  end

  def restart
    switch_game_state(Play)
  end

  def setup
    @font = Gosu::Font[35]
    @small = Gosu::Font[24]
    @copyright = Gosu::Font[16]
  end

  def draw
    super
    @font.draw_rel("You've killed #{score} zombies", $window.width/2, $window.height/2, 9990, 0.5, 1.0)
    @font.draw_rel(score.description, $window.width/2, $window.height/2, 9990, 0.5, 0.0)
    @small.draw_rel("Press Enter to try again", $window.width/2, $window.height-60, 9990, 0.5, 1.0)
    @copyright.draw_rel("© 2011 Semyon Perepelitsa http://sema.in", $window.width/2, $window.height-30, 9990, 0.5, 1.0)
    @copyright.draw_rel("Music by Xerferic", $window.width/2, $window.height-26, 9990, 0.5, 0.0)
  end
end
