require 'test_helper'

class Test::StatisticsTest < ActiveSupport::TestCase
  describe '#summary' do
    it 'returns a statistical summary' do
      results = [20, 40, 60, 80, 100].map { |p| OpenStruct.new(percentage: p) }
      test = Test.new(results)

      summary = Test::Statistics.new(test).summary

      expected = {mean: 60.0, stddev: 28.2843, min: 20.0, max: 100.0, p25: 40.0, p50: 60.0, p75: 80.0, count: 5}

      summary.each do |stat, value|
        assert_in_delta value, expected[stat], 0.0001
      end
    end
  end
end
