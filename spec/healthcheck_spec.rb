# frozen_string_literal: true

RSpec.describe Healthcheck, type: :module do
  it { expect(described_class::VERSION).not_to be nil }

  describe '.configure' do
    let(:name) { :zero_division }
    let(:block) { -> { 100 / 0 } }

    subject do
      described_class.configure do |config|
        config.success = 200
        config.error = 503
        config.verbose = false
        config.route = '/healthcheck'
        config.method = :get

        config.add_check(name, block)
      end
    end

    before { subject }

    it { expect(described_class.configuration.success).to eq(200) }
    it { expect(described_class.configuration.error).to eq(503) }
    it { expect(described_class.configuration.verbose).to eq(false) }
    it { expect(described_class.configuration.route).to eq('/healthcheck') }
    it { expect(described_class.configuration.method).to eq(:get) }
    it { expect(described_class.configuration.checks.first).to be_a(Healthcheck::Check) }
  end

  describe '.configuration' do
    subject { described_class.configuration }

    it { is_expected.to be_a(described_class::Configuration) }
  end

  describe '.routes' do
    subject { described_class.routes(nil) }

    after { subject }

    it { expect(Healthcheck::Router).to receive(:mount).once }
  end
end
