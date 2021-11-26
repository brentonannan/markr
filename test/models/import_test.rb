require 'test_helper'

class ImportTest < ActiveSupport::TestCase
  describe '#valid?' do
    it 'returns false if data is nil' do
      refute Import.new(nil).valid?
    end
  end

  describe 'save!' do
    it 'updates existing results' do
      record = Result.create!(test_id: SecureRandom.uuid, student_number: SecureRandom.uuid, obtained_mark: 6, available_marks: 9)
      data = {results: [{test_id: record.test_id, student_number: record.student_number, marks: {obtained: 7, available: 9}}]}

      Import.new(data).save!

      assert_equal record.reload.obtained_mark, 7
    end

    it 'creates new results' do
      ids = {test_id: SecureRandom.uuid, student_number: SecureRandom.uuid}
      data = {results: [{test_id: ids[:test_id], student_number: ids[:student_number], marks: {obtained: 7, available: 9}}]}

      Import.new(data).save!

      record = Result.find_by!(ids)
      assert_equal record.obtained_mark, 7
      assert_equal record.available_marks, 9
    end

    it 'raises an error on invalid data' do
      ids = {test_id: SecureRandom.uuid, student_number: SecureRandom.uuid}
      data = {results: [{test_id: ids[:test_id], student_number: ids[:student_number], marks: {obtained: 7, available: nil}}]}

      assert_raises(Import::InvalidImportError) { Import.new(data).save! }
    end
  end
end
