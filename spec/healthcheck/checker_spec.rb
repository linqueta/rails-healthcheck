# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Healthcheck::Checker, type: :model do
  describe '#initialize' do
    it { is_expected.to be_a(described_class) }
    it { expect(subject.errors).to be_empty }
  end

  describe '#check' do
    let(:checker) { described_class.new }
    subject { checker.check }

    before do
      Healthcheck.configure do |config|
        config.add_check :zero_division, -> { 100 / 0 }
        config.add_check :standard_error, -> { raise StandardError }
      end
    end

    context 'with errors' do
      let(:errors) { checker.errors }
      let(:standard_error) { errors.find { |error| error.name == :standard_error } }
      let(:zero_division) { errors.find { |error| error.name == :zero_division } }

      before { subject }

      it 'has two errors' do
        expect(errors.length).to eq(2)
        expect(standard_error.name).to eq(:standard_error)
        expect(standard_error.exception).to eq('StandardError')
        expect(standard_error.message).to eq('StandardError')
        expect(zero_division.name).to eq(:zero_division)
        expect(zero_division.exception).to eq('ZeroDivisionError')
        expect(zero_division.message).to eq('divided by 0')
      end
    end

    context 'without errors' do
      before do
        allow_any_instance_of(Healthcheck::Check).to receive(:execute!)
        subject
      end

      it 'hasnt errors' do
        expect(checker.errors).to be_empty
      end
    end
  end

  describe '#errored?' do
    let(:checker) { described_class.new }
    subject { checker.errored? }

    context 'without errors' do
      it { is_expected.to be_falsey }
    end

    context 'with errors' do
      before { checker.errors << 1 }

      it { is_expected.to be_truthy }
    end
  end
end
