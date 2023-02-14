class AccuweatherDataFormatter
  class << self
    def format(data)
      unless [Array, Hash].include?(data.class)
        raise 'Wrong AccuWeather data format'
      end
      if data.is_a?(Array)
        data.map { |datum| formatted_hash(datum) }
      else
        formatted_hash(data)
      end
    end

    def formatted_hash(datum)
      {
        temperature: datum.dig('Temperature', 'Metric', 'Value'),
        datetime: datum['EpochTime']
      }
    end
  end
end
