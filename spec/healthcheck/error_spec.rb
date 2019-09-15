# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Healthcheck::Error, type: :model do
  describe '#initialize' do
    let(:name) { :migrations }
    let(:exception) { StandardError }
    let(:message) { 'Migrations are pending. To resolve this issue, run: bin/rails db:migrate RAILS_ENV=production' }

    subject { described_class.new(name, exception, message) }

    it { is_expected.to be_a(described_class) }
    it { expect(subject.name).to eq(name) }
    it { expect(subject.exception).to eq(exception) }
    it { expect(subject.message).to eq(message) }
  end
end
