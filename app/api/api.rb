class API < Grape::API
  format :json
  mount Weather

  desc 'Server status'
  get '/health' do
    status :ok
  end
end
