require 'test_helper'

class Test::StatisticsTest < ActiveSupport::TestCase
  describe '#summary' do
    it 'returns a statistical summary' do
      results = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121].map { |s| OpenStruct.new(score: s) }
      test = Test.new(results)

      summary = Test::Statistics.new(test).summary

      expected = {mean: 46.0, stddev: 38.961519477556, min: 1, max: 121, p25: 9.0, p50: 36.0, p75: 81.0, count: 11}

      summary.each do |stat, value|
        assert_in_delta value, expected[stat], 0.0001
      end
    end
  end
end
