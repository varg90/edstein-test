class Weather < Grape::API
  format :json

  desc 'Current weather'
  get '/current' do
  end

  desc 'Server status'
  get '/health' do
    status :ok
  end
end
