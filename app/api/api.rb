class API < Grape::API
  prefix 'weather'
  mount Weather

  rescue_from :all
end
