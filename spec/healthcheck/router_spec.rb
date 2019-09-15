# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Healthcheck::Router, type: :model do
  describe '#mount' do
    let(:router) { double('Router') }

    subject { described_class.mount(router) }

    before do
      Healthcheck.configure do |config|
        config.method = :get
        config.route = '/healthcheck'
      end
    end

    after { subject }

    it do
      expect(router).to receive(:send).with(Healthcheck.method, Healthcheck.route => 'healthcheck#check')
    end
  end
end
