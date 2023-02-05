describe AccuweatherClient do
  subject { described_class.new }

  describe '#get_historical_data' do
    it 'get a correct weather data' do
      expect(
        subject.get_historical_data&.all? { |datum|
          (%w[EpochTime Temperature]).all? { |key| datum.key?(key) }
        }
      ).to be_truthy
    end
  end
end
