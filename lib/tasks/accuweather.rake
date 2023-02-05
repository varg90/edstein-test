namespace :accuweather do
  desc 'Get Historical Data from AccuWeather and save it to the DB'
  task get_historical_data: :environment do
    client = AccuweatherClient.new
    client.get_historical_data.each do |datum|
      ::WeatherDatum
        .create_with(temperature: datum.dig('Temperature', 'Metric', 'Value'))
        .find_or_create_by(datetime: datum['EpochTime'])
    end
  end
end
