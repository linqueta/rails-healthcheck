# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Healthcheck::Configuration, type: :model do
  describe '#initialize' do
    subject { described_class.new }

    it { is_expected.to be_a(described_class) }
    it do
      expect(
        described_class::SETTINGS.map { |setting| subject.send(setting) }.all?(&:nil?)
      ).to be_truthy
    end
  end
end
