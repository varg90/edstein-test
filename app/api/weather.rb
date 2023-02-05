class Weather < Grape::API
  format :json

  rescue_from :all

  prefix 'weather'

  helpers do
    def last_day_data
      WeatherDatum.where(
        datetime: ((Time.current - 1.day).to_i..Time.current.to_i)
      )
    end
  end

  desc 'Current weather'
  get '/current' do
  end

  desc 'Server status'
  get '/health' do
    status :ok
  end

  namespace :historical do
    desc 'Hourly temperature for the last day'
    get '/' do
      last_day_data.order(:datetime)
    end

    desc 'Max temperature for the last day'
    get '/max' do
      last_day_data.order(temperature: :desc).first
    end

    desc 'Min temperature for the last day'
    get '/min' do
      last_day_data.order(:temperature).first
    end

    desc 'Average temperature for the last day'
    get '/avg' do
      last_day_data.average(:temperature)
    end
  end

  params { requires :timestamp, type: Integer }
  get '/by_time' do
    error!('Not found', 404) unless params[:timestamp].present?

    WeatherDatum.order(Arel.sql("ABS(datetime - #{params[:timestamp].to_i})"))
      .first
  end
end
