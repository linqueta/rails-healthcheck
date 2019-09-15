# frozen_string_literal: true

RSpec.describe HealthcheckController, type: :model do
  describe '#check' do
    let(:controller) { described_class.new }
    subject { controller.check }

    after { subject }

    context 'when check with success' do
      before { expect_any_instance_of(Healthcheck::Checker).to receive(:errored?).and_return(Healthcheck.success) }

      it 'returns success code' do
        expect(controller).to receive(:head).with(Healthcheck.success).once
      end
    end
  end
end
