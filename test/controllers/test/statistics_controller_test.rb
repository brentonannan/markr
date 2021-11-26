require 'test_helper'

class Test::StatisticsControllerTest < ActionDispatch::IntegrationTest
  describe '#show' do
    it 'returns a 404 if no results are found' do
      get test_statistics_path(SecureRandom.uuid)

      assert_response(404)
    end
  end

  it 'renders a summary of records for the given test' do
    test_id = SecureRandom.uuid
    (1..5).each do |mark|
      Result.create!(test_id: test_id, student_number: SecureRandom.uuid, obtained_mark: mark, available_marks: 5)
    end

    get test_statistics_path(test_id)

    assert_equal response.status, 200
    summary = JSON.parse(response.body)
    expected = {"mean" => 60.0, "min" => 20.0, "max" => 100.0, "stddev" => 28.2843, "p25" => 40.0, "p50" => 60.0, "p75" => 80.0, "count" => 5}

    summary.each do |statistic, value|
      assert_in_delta value, expected[statistic], 0.0001
    end
  end
end
