class Score
  def initialize
    @value = 0
  end

  def description
    case @value
    when 0..9
      ""
    when 10..19
      "Good!"
    when 20..29
      "Nice!"
    when 30..39
      "Cool!"
    when 40..49
      "Wow!"
    when 50..59
      "Amazing!"
    when 60..69
      "Awesome!"
    when 70..99
      "Freaking Awesome!"
    when 100..149
      "Unbelieveable!"
    else
      "Godlike!"
    end
  end

  def to_s
    number_with_delimiter(@value, separator: ' ')
  end

  def increment
    @value += 1
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
