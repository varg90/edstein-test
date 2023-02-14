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
  let(:response_body) { JSON.parse(last_response.body).symbolize_keys }

  before do
    allow(Time).to receive(:now).and_return(Time.at(1_675_609_635))
    allow(Time).to receive(:current).and_return(Time.at(1_675_609_635))

    daily_timestamps.each_with_index do |timestamp, index|
      create(:weather_datum, temperature: -10.0 + index, datetime: timestamp)
    end
  end

  context 'GET /weather/current' do
    it 'returns a current weather' do
      # TODO: mock the API request in tests
      get '/weather/current'
      expect(last_response.status).to eq(200)
    end
  end

  context 'GET /weather/historical' do
    it 'returns historical temperature for the last 24 hours' do
      get '/weather/historical'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).size).to eq 24
    end
  end

  context 'GET /weather/historical/max' do
    it 'returns a maximum temperature for the last 24 hours' do
      get '/weather/historical/max'
      expect(last_response.status).to eq(200)
      expect(response_body).to include(
        temperature: 13.0,
        datetime: 1_675_609_635
      )
    end
  end

  context 'GET /weather/historical/min' do
    it 'returns a minimum temperature for the last 24 hours' do
      get '/weather/historical/min'
      expect(last_response.status).to eq(200)
      expect(response_body).to include(
        temperature: -10.0,
        datetime: 1_675_526_835
      )
    end
  end

  context 'GET /weather/historical/avg' do
    it 'returns an average temperature for the last 24 hours' do
      get '/weather/historical/avg'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq 1.5
    end
  end

  context 'GET /weather/by_time'
  it 'returns a temperature for the closest to a specified timestamp' do
    get '/weather/by_time?timestamp=1675619635'
    expect(last_response.status).to eq(200)
    expect(response_body).to include(temperature: 13.0, datetime: 1_675_609_635)
  end
  it 'returns not_found if the timestamp is empty' do
    get '/weather/by_time?timestamp='
    expect(last_response.status).to eq(404)
  end
  it 'returns bad_request if the timestamp param was not provided' do
    get '/weather/by_time'
    expect(last_response.status).to eq(400)
  end
end
