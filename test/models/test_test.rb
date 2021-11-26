require 'test_helper'

class TestTest < ActiveSupport::TestCase
  describe '.find' do
    it 'returns an object with persisted Results' do
      result = Result.create!(test_id: SecureRandom.uuid, student_number: SecureRandom.uuid, obtained_mark: 7, available_marks: 9)

      test = Test.find(result.test_id)

      assert_equal test.results, [result]
    end
  end
end
