# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Healthcheck', type: :request do
  describe '/healthcheck' do
    subject { get '/healthcheck' }

    before do
      Healthcheck.configuration.add_check :year_check, -> { raise StandardError, 'year' if Time.current.year == 1969 }
      Healthcheck.configuration.add_check :sum_check, -> { [1, 2, 3].sum == 6 }
    end

    context 'all ok' do
      before { subject }

      it { expect(response.code) == Healthcheck.configuration.success }
      it { expect(response.body).to eq('') }
    end

    context 'with error in one check' do
      context 'verbose true' do
        before do
          Healthcheck.configuration.verbose = true
          Timecop.freeze(Time.parse('19690101')) { subject }
        end

        it { expect(response.code) == Healthcheck.configuration.error }
        it { expect(response.body).not_to eq('') }
        it do
          expect(JSON.parse(response.body)).to eq(
            'code' => Healthcheck.configuration.error,
            'errors' => [
              {
                'exception' => 'StandardError',
                'message' => 'year',
                'name' => 'year_check'
              }
            ]
          )
        end
      end

      context 'verbose false' do
        before do
          Healthcheck.configuration.verbose = false
          Timecop.freeze(Time.parse('19690101')) { subject }
        end

        it { expect(response.code) == Healthcheck.configuration.error }
        it { expect(response.body).to eq('') }
      end
    end
  end
end
