class Score
  def initialize
    @value = 0
  end

  def description
    case @value
    when 0..9
      ""
    when 10..19
      "OK"
    when 20..29
      "Good!"
    when 30..39
      "Nice!"
    when 40..49
      "Cool!"
    when 50..59
      "Wow!"
    when 60..79
      "Very Cool!"
    when 80..99
      "Amazing"
    when 100..149
      "Freaking Awesome!"
    when 150..249
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
