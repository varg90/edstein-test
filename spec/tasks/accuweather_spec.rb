describe 'accuweather:get_historical_data', type: :rake do
  it 'fetches weather data and saves it to the DB' do
    expect { subject.invoke }.to change { ::WeatherDatum.count }.by 24
  end
end
