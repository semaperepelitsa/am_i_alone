require "chingu"
require "player"
require "cursor"
require "zombi"
require "health_bar"
require "score_bar"
require "help_bar"
require "dead"

class Play < Chingu::GameState
  traits :viewport, :timer

  def setup
    $play_count += 1
    # viewport.game_area = [ 0, 0,   3000, $window.height]
    @fog = Gosu::Image['fog.png']
    @parallax = Chingu::Parallax.new(:x => 0, :y => 0, :rotation_center => :top_left)
    @parallax.add_layer(
      :image => "grass.png",
      :repeat_x => true,
      :repeat_y => false,
      # :damping => 5
    )
    @music = Gosu::Song['music.mp3']
    @music.play(true)

    self.input = { :p => :pause }

    @cursor = Cursor.new(viewport: viewport)
    @score = Score.new
    HelpBar.create if $play_count < 3

    @player = Player.create(
      x: $window.width/2, y: $window.height/2,
      game_area: viewport.game_area, cursor: @cursor, weapon: Handgun.create,
      score: @score
    )
    @health_bar = HealthBar.new(victim: @player)
    @score_bar = ScoreBar.new(score: @score)

    @powerup_sound = Gosu::Sound['powerup.wav']
    @wave = 1
    spawn(3)
    will_spawn
  end

  def spawn(n = nil)
    n ||= 2 + @wave * 2
    @speed = 0.8 + 0.1 * @wave
    @speed = 3 if @speed > 3
    n.times do |i|
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
      Zombi.create(x: x, y: y, game_area: viewport.game_area, target: @player, speed: @speed)
    end
  end

  def will_spawn
    @wave += 1
    if @wave % 5 == 0
      @player.increase_hp
      @player.upgrade_weapon
      @powerup_sound.play
    end
    delay = 5000 - @wave * (100 * 1/(@wave*@wave))
    # delay = 300
    delay = 1000 if delay < 1000
    after(delay) do
      spawn
      will_spawn
    end
  end

  def draw
    super
    @fog.draw(0, 0, 9000)
    @parallax.draw
    @health_bar.draw
    @score_bar.draw
    viewport.apply { @cursor.draw }
  end

  def update
    super
    $window.caption = "Am I Alone? Wave #{@wave}"
    $window.caption += " speed: #{@speed}" if $development
    viewport.center_around(@player)
    @parallax.camera_x, @parallax.camera_y = self.viewport.x.to_i, self.viewport.y.to_i
    @parallax.update
    @health_bar.update
    @score_bar.update
    @cursor.update
    switch_game_state(Dead.new(score: @score)) if @player.dead?
    Bullet.destroy_if{ |bullet| bullet.outside_window? }
  end

  def pause
    push_game_state(Chingu::GameStates::Pause)
  end
end
