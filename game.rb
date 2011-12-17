require "chingu"
include Gosu

class Game < Chingu::Window
  def setup
    push_game_state(Play)
    self.input = { :escape => :exit }
  end
end

class Play < Chingu::GameState
  def setup
    Player.create(x: 50, y: 300)
    @bg = Color::GREEN
  end

  def draw
    super
    fill @bg
  end
end

class Player < Chingu::GameObject
  traits :velocity
  SPEED = 3

  def initialize(options = {})
    super(options.merge(image: Image['player.png']))
    self.input = [ :holding_left,
                   :holding_right,
                   :holding_up,
                   :holding_down ]
  end

  def holding_left
    move(-SPEED, 0)
  end

  def holding_right
    move(SPEED, 0)
  end

  def holding_up
    move(0, -SPEED)
  end

  def holding_down
    move(0, SPEED)
  end
end

Game.new(800, 600, false).show
