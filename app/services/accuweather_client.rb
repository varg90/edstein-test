require 'net/http'
require 'uri'

class AccuweatherClient
  def initialize(location: ENV['ACCUWEATHER_LOCATION_KEY'], version: 'v1')
    @location = location
    @version = version
  end

  def get_historical_data
    api_request('/historical/24')
  end

  def get_current_conditions
    api_request
  end

  private

  def api_request(path = '')
    begin
      uri =
        URI(
          "#{ENV['ACCUWEATHER_API_URL']}/#{@version}" + "/#{@location}#{path}"
        )
      uri.query = URI.encode_www_form({ apikey: ENV['ACCUWEATHER_API_KEY'] })
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri)

      response = http.request(request)
      response.kind_of?(Net::HTTPSuccess) ? JSON.parse(response.body) : nil
    rescue Timeout::Error,
           Errno::EINVAL,
           Errno::ECONNRESET,
           EOFError,
           Net::HTTPBadResponse,
           Net::HTTPHeaderSyntaxError,
           Net::ProtocolError => e
      Logger.new("#{Rails.root}/log/accuweather_error.log").error e.message
    end
  end
end
