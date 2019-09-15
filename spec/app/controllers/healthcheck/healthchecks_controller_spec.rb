# frozen_string_literal: true

RSpec.describe Healthcheck::HealthchecksController, type: :model do
  describe '#check' do
    let(:controller) { described_class.new }
    let(:verbose) { false }

    subject { controller.check }

    before do
      Healthcheck.configure do |config|
        config.success = 200
        config.error = 503
        config.verbose = verbose
        config.add_check :zero_division, -> { 100 / 0 }
        config.add_check :standard_error, -> { raise StandardError }
      end
    end

    after { subject }

    context 'when check with success' do
      before { allow_any_instance_of(Healthcheck::Check).to receive(:execute!) }

      it 'returns success code' do
        expect(controller).to receive(:head).with(Healthcheck.success).once
      end
    end

    context 'when check without success' do
      context 'without verbose setting' do
        it { expect(controller).to receive(:head).with(Healthcheck.error).once }
      end

      context 'with verbose setting' do
        let(:verbose) { true }

        it { expect(controller).to receive(:render).once }
      end
    end
  end
end
