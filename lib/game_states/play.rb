require "chingu"
require "player"
require "cursor"
require "zombi"

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

    self.input = { :p => :pause }

    @cursor = Cursor.new(viewport: viewport)

    @player = Player.create(x: 50, y: 300, game_area: viewport.game_area, cursor: @cursor, weapon: Handgun.create)
    (n = 5).times do |i|
      Zombi.create(x: 300+rand(100), y: 10 + i * 500/n, game_area: viewport.game_area, target: @player)
    end
  end

  def draw
    super
    @parallax.draw
    viewport.apply { @cursor.draw }
  end

  def update
    super
    viewport.center_around(@player)
    @parallax.camera_x, @parallax.camera_y = self.viewport.x.to_i, self.viewport.y.to_i
    @parallax.update
    @cursor.update
  end

  def pause
    push_game_state(Chingu::GameStates::Pause)
  end
end
