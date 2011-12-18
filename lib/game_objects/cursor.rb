require "chingu"

class Cursor < Chingu::GameObject
  attr_accessor :viewport

  def initialize(options = {})
    super({image: 'cursor.png', zorder: 9000}.merge(options))
    self.viewport = options.fetch(:viewport)
  end

  def update
    super
    self.x = viewport.x + $window.mouse_x
    self.y = viewport.y + $window.mouse_y
  end
end
