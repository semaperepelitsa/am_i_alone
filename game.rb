require "chingu"
include Gosu

class Game < Chingu::Window
  def setup
    push_game_state(Play)
    self.input = { :escape => :exit }
  end
end

class Play < Chingu::GameState
  traits :viewport

  def setup
    viewport.game_area = [ 0, 0,   3000, $window.height]
    @parallax = Chingu::Parallax.new(:x => 0, :y => 0, :rotation_center => :top_left)
    @parallax.add_layer(
      :image => "grass.png",
      :repeat_x => true,
      :repeat_y => false,
      # :damping => 5
    )

    @player = Player.create(x: 50, y: 300, zorder: 300)
    @bg = Color::GREEN
  end

  def draw
    super
    fill @bg
    @parallax.draw
  end

  def update
    super
    viewport.center_around(@player)
    @parallax.camera_x, @parallax.camera_y = self.viewport.x.to_i, self.viewport.y.to_i
    @parallax.update
  end
end

class Wall < Chingu::GameObject
  def intitialize(options = {})
    super(options.merge(image: Image['wall.png']))
  end
end

class Player < Chingu::GameObject
  traits :velocity
  SPEED = 3

  def initialize(options = {})
    super(options.merge(image: 'player.png'))
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
