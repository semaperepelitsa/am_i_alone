class Score
  def initialize
    @value = 0
  end

  def description
    case @value
    when 0..19
      ""
    when 20..49
      "OK"
    when 50..79
      "Good!"
    when 80..99
      "Nice!"
    when 100..199
      "Cool!"
    when 200..399
      "Wow!"
    when 400..599
      "Very Cool!"
    when 600..799
      "Amazing!"
    when 800..999
      "Freaking Awesome!"
    when 1000..1499
      "Unbelieveable!"
    else
      "Godlike!"
    end
  end

  def to_s
    if @cached_value == @value
      @cached_string
    else
      @cached_value = @value
      @cached_string = number_with_delimiter(@value, separator: ' ')
    end
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
