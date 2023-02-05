describe Weather do
  include Rack::Test::Methods

  def app
    API
  end

  context 'GET /health' do
    it 'returns the server health status' do
      get '/health'
      expect(last_response.status).to eq(200)
    end
  end
end
