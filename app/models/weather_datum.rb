class WeatherDatum < ApplicationRecord
  validates :temperature, :datetime, presence: true
end
