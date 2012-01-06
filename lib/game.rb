require "chingu"
require "play"
require "logger"

class Game < Chingu::Window
  def setup
    $play_count = 0
    $logger = Logger.new(STDOUT)
    $logger.level = Logger::DEBUG
    push_game_state(Play)
  end
end
