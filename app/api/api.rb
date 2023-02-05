class API < Grape::API
  format :json
  mount Weather

  desc 'Server status'
  get '/health' do
    status :ok
  end

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end

  add_swagger_documentation
end
