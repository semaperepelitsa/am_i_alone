require "chingu"
require "play"
require "logger"

class Game < Chingu::Window
  def setup
    $logger = Logger.new(STDOUT)
    $logger.level = Logger::DEBUG
    push_game_state(Play)
  end
end
