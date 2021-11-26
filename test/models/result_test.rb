require "test_helper"

class ResultTest < ActiveSupport::TestCase
  describe '.new' do
    it 'defaults scores to zero' do
      result = Result.new

      assert_equal result.obtained_mark, 0
      assert_equal result.available_marks, 0

      result = Result.new(obtained_mark: 7, available_marks: 9)

      assert_equal result.obtained_mark, 7
      assert_equal result.available_marks, 9
    end
  end

  describe '#update_marks' do
    it 'updates marks with if and only if new mark is greater than existing' do
      result = Result.new(obtained_mark: 6, available_marks: 7)

      result.update_marks(obtained_mark: 7, available_marks: 9)

      assert_equal result.obtained_mark, 7
      assert_equal result.available_marks, 9

      result.update_marks(obtained_mark: 3, available_marks: 5)

      assert_equal result.obtained_mark, 7
      assert_equal result.available_marks, 9
    end
  end

  describe 'score' do
    it 'returns a Rational' do
      assert Result.new(obtained_mark: 7, available_marks: 9), Rational(7, 9)
    end
  end
end
