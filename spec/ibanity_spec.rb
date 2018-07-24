describe Ibanity do
  before(:each) do
    Ibanity.configure do |config|
      config.certificate = ENV['IBANITY_CERTIFICATE']
      config.key = ENV['IBANITY_KEY']
      config.key_passphrase = ENV['IBANITY_PASSPHRASE']
    end
  end
  describe '.configuration' do
    it 'initializes the client configuration' do
      expect(Ibanity.instance_variable_defined?(:@configuration)).to eq(true)
      expect(Ibanity.configuration.is_a?(Struct)).to eq(true)
      config_keys = [:certificate, :key, :key_passphrase]
      expect(config_keys & Ibanity.configuration.to_h.keys).to eq(config_keys)
    end
  end
end

