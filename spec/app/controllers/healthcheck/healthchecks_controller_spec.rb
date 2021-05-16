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
      end
    end

    after { subject }

    context 'when check with success' do
      before { allow_any_instance_of(Healthcheck::Check).to receive(:execute!) }

      context 'without verbose setting' do
        it 'returns success code' do
          expect(controller).to receive(:head).with(Healthcheck.configuration.success).once
        end
      end

      context 'with verbose setting' do
        let(:verbose) { true }

        it 'returns verbose response' do
          expect(controller)
            .to receive(:render)
            .with(
              status: Healthcheck.configuration.success,
              json: {
                code: Healthcheck.configuration.success,
                status: { zero_division: 'OK' }
              }
            )
            .once
        end
      end
    end

    context 'when check without success' do
      context 'without verbose setting' do
        it { expect(controller).to receive(:head).with(Healthcheck.configuration.error).once }
      end

      context 'with verbose setting' do
        let(:verbose) { true }

        it 'returns verbose response' do
          expect(controller)
            .to receive(:render)
            .with(
              json: {
                code: Healthcheck.configuration.error,
                errors: [
                  {
                    'exception' => 'ZeroDivisionError',
                    'message' => 'divided by 0',
                    'name' => 'zero_division'
                  }
                ]
              },
              status: Healthcheck.configuration.error
            )
            .once
        end
      end
    end

    context 'with custom' do
      it do
        Healthcheck.configure do |config|
          config.custom = lambda { |controller, checker|
            controller.head :ok if checker.success?
          }
        end

        expect(Healthcheck.configuration.custom).to receive(:call).once
        subject

        Healthcheck.configure do |config|
          config.custom = nil
        end
      end
    end
  end
end
