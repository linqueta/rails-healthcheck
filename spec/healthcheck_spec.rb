# frozen_string_literal: true

RSpec.describe Healthcheck, type: :module do
  it { expect(described_class::VERSION).not_to be nil }

  describe '.configure' do
    let(:configuration) { described_class.configuration }

    subject do
      described_class.configure do |config|
        config.success = 200
        config.error = 503
        config.verbose = false
        config.route = '/healthcheck'
        config.method = :get
        config.parallel = true
        config.all = false
      end
    end

    before { subject }

    it { expect(configuration.success).to eq(200) }
    it { expect(configuration.error).to eq(503) }
    it { expect(configuration.verbose).to eq(false) }
    it { expect(configuration.route).to eq('/healthcheck') }
    it { expect(configuration.method).to eq(:get) }
    it { expect(configuration.parallel).to eq(true) }
    it { expect(configuration.all).to eq(false) }
  end

  describe '.configuration' do
    subject { described_class.configuration }

    it { is_expected.to be_a(described_class::Configuration) }
  end
end
