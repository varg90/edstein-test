describe Weather do
  include Rack::Test::Methods

  def app
    Weather
  end

  let(:daily_timestamps) do
    [
      1_675_526_835,
      1_675_530_435,
      1_675_534_035,
      1_675_537_635,
      1_675_541_235,
      1_675_544_835,
      1_675_548_435,
      1_675_552_035,
      1_675_555_635,
      1_675_559_235,
      1_675_562_835,
      1_675_566_435,
      1_675_570_035,
      1_675_573_635,
      1_675_577_235,
      1_675_580_835,
      1_675_584_435,
      1_675_588_035,
      1_675_591_635,
      1_675_595_235,
      1_675_598_835,
      1_675_602_435,
      1_675_606_035,
      1_675_609_635
    ]
  end

  before do
    daily_timestamps.each_with_index do |timestamp, index|
      create(:weather_datum, temperature: -10 + index, datetime: timestamp)
    end
  end

  context 'GET /weather/current' do
    it 'returns an empty array of statuses' do
      get '/weather/current'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).symbolize_keys).to include(
        temperature: 13.0,
        datetime: 1_675_609_635
      )
    end
  end
end
