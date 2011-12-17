require "chingu"
require "play"

class Game < Chingu::Window
  def setup
    push_game_state(Play)
    self.input = { :escape => :exit }
  end
end
