require 'representable/json'

class WeatherDatumRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :temperature
  property :datetime
end
