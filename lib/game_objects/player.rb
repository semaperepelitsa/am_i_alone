require "chingu"
require "handgun"
require "score"

class Player < Chingu::GameObject
  traits :velocity, :bounding_circle, :timer
  SPEED = 3

  attr_accessor :cursor, :hp
  attr_reader :weapon, :score

  def initialize(options = {})
    super(options.merge(image: 'player.png', zorder: 300))
    self.input = { :holding_a => :move_left,
                   :holding_d => :move_right,
                   :holding_w => :move_up,
                   :holding_s => :move_down }

    self.cursor = options.fetch(:cursor)
    self.weapon = options[:weapon]
    @game_area = options.fetch(:game_area)
    @hp = 10
    @score = options.fetch(:score)
    @invunerable_for = 400
    @invunerable_alpha = 150
  end

  def weapon=(new_weapon)
    @weapon = new_weapon
    @weapon.player = self
  end

  def update
    super

    if @thrown and velocity_x * acceleration_x > 0
      @thrown = false
      self.acceleration_x = 0
      self.acceleration_y = 0
      self.velocity_x = 0
      self.velocity_y = 0
      during(@invunerable_for) do
        self.alpha += (255 - @invunerable_alpha).to_f/@invunerable_for
      end
      after(@invunerable_for + 1){ self.alpha = 255; self.collidable = true }
    end

    self.angle = Gosu.angle(x, y, @cursor.x, @cursor.y)

    self.y = @game_area.top    if self.y < @game_area.top
    self.y = @game_area.bottom if self.y > @game_area.bottom

    self.x = @game_area.left   if self.x < @game_area.left
    self.x = @game_area.right  if self.x > @game_area.right
  end

  def angle_rad=(value)
    @angle = value * 180 / Math::PI
  end

  def move_left
    move(-SPEED, 0)
  end

  def move_right
    move(SPEED, 0)
  end

  def move_up
    move(0, -SPEED)
  end

  def move_down
    move(0, SPEED)
  end

  def hit_by(enemy)
    @hp -= enemy.damage
    @velocity_x = Gosu.offset_x(enemy.angle, 20)
    @velocity_y = Gosu.offset_y(enemy.angle, 20)
    @acceleration_x = - @velocity_x / 10
    @acceleration_y = - @velocity_y / 10
    @thrown = true
    self.alpha = @invunerable_alpha
    self.collidable = false
    die unless @hp > 0
  end

  def killed(enemy)
    @score.increment
  end

  def die
    @dead = true
  end

  def increase_hp
    self.hp += 1
  end

  def dead?
    @dead
  end
end
