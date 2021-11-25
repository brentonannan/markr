require 'test_helper'

class Import::ParseXmlTest < ActiveSupport::TestCase
  describe '.call' do
    it 'parses valid complete xml into simple relevant text data' do
      xml = <<-XML
        <?xml version="1.0" encoding="UTF-8" ?>
        <mcq-test-results>
          <mcq-test-result scanned-on="2017-12-04T12:12:10+11:00">
            <first-name>Gary</first-name>
            <last-name>McGhernikan</last-name>
            <student-number>777</student-number>
            <test-id>1234</test-id>
            <answer question="0" marks-available="1" marks-awarded="1">D</answer>
            <answer question="1" marks-available="1" marks-awarded="1">D</answer>
            <summary-marks available="20" obtained="13" />
          </mcq-test-result>
          <mcq-test-result scanned-on="2017-12-04T12:13:10+11:00">
            <first-name>Larry</first-name>
            <last-name>McLhernikan</last-name>
            <student-number>999</student-number>
            <test-id>1234</test-id>
            <summary-marks available="20" obtained="8" />
          </mcq-test-result>
          <mcq-test-result scanned-on="2017-12-04T12:13:30+11:00">
            <first-name>Harry</first-name>
            <last-name>McHhernikan</last-name>
            <student-number>888</student-number>
            <test-id>4321</test-id>
            <summary-marks available="30" obtained="27" />
          </mcq-test-result>
        </mcq-test-results>
      XML

      parsed = Import::ParseXml.call(xml)
      expected = {results: [
        {student_number: "777", test_id: "1234", marks: {obtained: "13", available: "20"}},
        {student_number: "999", test_id: "1234", marks: {obtained: "8", available: "20"}},
        {student_number: "888", test_id: "4321", marks: {obtained: "27", available: "30"}},
      ]}

      assert_equal parsed, expected
    end

    it 'parses valid  xml without header into simple relevant text data' do
      xml = <<-XML
        <mcq-test-results>
          <mcq-test-result scanned-on="2017-12-04T12:12:10+11:00">
            <first-name>Gary</first-name>
            <last-name>McGhernikan</last-name>
            <student-number>777</student-number>
            <test-id>1234</test-id>
            <summary-marks available="20" obtained="13" />
          </mcq-test-result>
        </mcq-test-results>
      XML

      parsed = Import::ParseXml.call(xml)
      expected = {results: [
        {student_number: "777", test_id: "1234", marks: {obtained: "13", available: "20"}},
      ]}

      assert_equal parsed, expected
    end

    it 'returns nils for missing values' do
      xml = <<-XML
        <?xml version="1.0" encoding="UTF-8" ?>
        <mcq-test-results>
          <mcq-test-result scanned-on="2017-12-04T12:12:10+11:00">
            <first-name>Gary</first-name>
            <last-name>McGhernikan</last-name>
            <student-number></student-number>
            <test-id></test-id>
            <answer question="0" marks-available="1" marks-awarded="1">D</answer>
            <answer question="1" marks-available="1" marks-awarded="1">D</answer>
            <summary-marks />
          </mcq-test-result>
          <mcq-test-result scanned-on="2017-12-04T12:13:10+11:00">
            <first-name>Larry</first-name>
            <last-name>McLhernikan</last-name>
            <student-number>999</student-number>
            <test-id>1234</test-id>
          </mcq-test-result>
        </mcq-test-results>
      XML

      parsed = Import::ParseXml.call(xml)
      expected = {results: [
        {student_number: nil, test_id: nil, marks: {obtained: nil, available: nil}},
        {student_number: "999", test_id: "1234", marks: {obtained: nil, available: nil}},
      ]}

      assert_equal parsed, expected
    end

    it 'returns nil if xml is invalid' do
      unclosed_tag = <<-XML
        <?xml version="1.0" encoding="UTF-8" ?>
        <mcq-test-results>
          <mcq-test-result scanned-on="2017-12-04T12:12:10+11:00">
            <first-name>Gary</first-name>
            <last-name>McGhernikan</last-name>
            <student-number>777</student-number>
            <test-id>1234</test-id>
            <summary-marks available="20" obtained="13" />
          </mcq-test-result>
      XML

      assert_nil Import::ParseXml.call(unclosed_tag)
    end
  end
end
