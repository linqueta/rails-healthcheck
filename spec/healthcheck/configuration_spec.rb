# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Healthcheck::Configuration, type: :model do
  describe '#initialize' do
    subject { described_class.new }

    it { is_expected.to be_a(described_class) }
    it { expect(subject.success).to be_nil }
    it { expect(subject.error).to be_nil }
    it { expect(subject.verbose).to be_nil }
    it { expect(subject.route).to be_nil }
    it { expect(subject.method).to be_nil }
    it { expect(subject.checks).to be_empty }
  end

  describe '#add_check' do
    let(:name) { :zero_division }
    let(:block) { -> { 100 / 0 } }
    let(:instance) { described_class.new }

    subject { instance.add_check(name, block) }

    before { subject }

    it { expect(instance.checks).not_to be_empty }
    it { expect(instance.checks.length).to eq(1) }
    it { expect(instance.checks.first).to be_a(Healthcheck::Check) }
  end
end
