describe WeatherDatum do
  let(:weather) { create(:weather_datum) }

  it { expect(weather).to be_valid }
end
