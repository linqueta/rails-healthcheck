# frozen_string_literal: true

RSpec.describe Healthcheck, type: :module do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end
end
