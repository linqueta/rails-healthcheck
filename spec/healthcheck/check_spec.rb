# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Healthcheck::Check, type: :model do
  let(:name) { :zero_division }
  let(:block) { -> { 100 / 0 } }

  subject { described_class.new(name, block) }

  it { is_expected.to be_a(described_class) }
  it { expect(subject.name).to eq(name) }
  it { expect(subject.block).to eq(block) }
end
