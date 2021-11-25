require 'ox'

module Import::ParseXml
  class << self
    def call(xml)
      doc = Ox.parse(xml)
      {results: results(doc)}
    rescue Ox::ParseError
      nil
    end

    private

    def results(doc)
      doc.locate('*/mcq-test-result').map do |result|
        {
          test_id: test_id(result),
          student_number: student_number(result),
          marks: marks(result),
        }
      end
    end

    def student_number(result)
      result.locate('student-number').last&.text
    end

    def test_id(result)
      result.locate('test-id').last&.text
    end

    def marks(result)
      marks = result.locate('summary-marks').last&.attributes || {}
      {obtained: marks[:obtained], available: marks[:available]}
    end
  end
end
