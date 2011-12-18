require "chingu"

class ScoreBar < Chingu::BasicGameObject
  def initialize(options = {})
    super
    @player = options[:player]

    @x = $window.width  - 20
    @y = $window.height - 20
    @zorder = 9000

    @font = Gosu::Font[35]
  end

  def score
    @player.score
  end

  def formatted_score
    number_with_delimiter(score, separator: ' ')
  end

  def draw
    @font.draw_rel(formatted_score, @x, @y, 9900, 1.0, 1.0)
  end

private

  def number_with_delimiter(number, options = {})
    begin
      Float(number)
    rescue ArgumentError, TypeError
      if options[:raise]
        raise InvalidNumberError, number
      else
        return number
      end
    end

    parts = number.to_s.to_str.split('.')
    parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{options[:delimiter]}")
    parts.join(options[:separator])
  end
end
