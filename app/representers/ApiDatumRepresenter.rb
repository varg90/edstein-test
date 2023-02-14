require 'representable/json'

class ApiDatumRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :temperature
  property :datetime
end
