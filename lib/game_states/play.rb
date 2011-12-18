require "chingu"
require "player"
require "cursor"
require "zombi"
require "health_bar"
require "score_bar"
require "dead"

class Play < Chingu::GameState
  traits :viewport, :timer

  def setup
    # viewport.game_area = [ 0, 0,   3000, $window.height]
    @parallax = Chingu::Parallax.new(:x => 0, :y => 0, :rotation_center => :top_left)
    @parallax.add_layer(
      :image => "grass.png",
      :repeat_x => true,
      :repeat_y => false,
      # :damping => 5
    )

    self.input = { :p => :pause }

    @cursor = Cursor.new(viewport: viewport)
    @score = Score.new

    @player = Player.create(
      x: $window.width/2, y: $window.height/2,
      game_area: viewport.game_area, cursor: @cursor, weapon: Handgun.create,
      score: @score
    )
    @health_bar = HealthBar.new(victim: @player)
    @score_bar = ScoreBar.new(score: @score)

    every(1000) do
      (n = 5).times do |i|
        margin = 30
        if rand > 0.5
          x = rand(margin)
          x = $window.width - x if rand > 0.5
          y = rand($window.height)
        else
          x = rand($window.width)
          y = rand(margin)
          y = $window.height - y if rand > 0.5
        end
        Zombi.create(x: x, y: y, game_area: viewport.game_area, target: @player)
      end
    end
  end

  def draw
    super
    @parallax.draw
    @health_bar.draw
    @score_bar.draw
    viewport.apply { @cursor.draw }
  end

  def update
    super
    viewport.center_around(@player)
    @parallax.camera_x, @parallax.camera_y = self.viewport.x.to_i, self.viewport.y.to_i
    @parallax.update
    @health_bar.update
    @score_bar.update
    @cursor.update
    switch_game_state(Dead.new(score: @score)) if @player.dead?
  end

  def pause
    push_game_state(Chingu::GameStates::Pause)
  end
end
