require 'test_helper'

class ImportsControllerTest < ActionDispatch::IntegrationTest
  def create(body: nil, content_type: ImportsController::CONTENT_TYPE)
    post import_path, env: {'RAW_POST_DATA' => body}, headers: {'Content-Type' => content_type}
  end

  describe '#create' do
    it 'returns a 406 for invalid content-types' do
      ['text/xml', 'application/xml', 'text/html'].each do |content_type|
        create(content_type: content_type)

        assert_response(406)
      end
    end

    it 'returns bad request for invalid XML' do
      invalid_xml = <<-XML
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

      create(body: invalid_xml)

      assert_response(400)
    end

    it 'saves results from valid XML' do
      test_id = SecureRandom.uuid
      valid_xml = <<-XML
        <?xml version="1.0" encoding="UTF-8" ?>
        <mcq-test-results>
          <mcq-test-result scanned-on="2017-12-04T12:12:10+11:00">
            <first-name>Gary</first-name>
            <last-name>McGhernikan</last-name>
            <student-number>777</student-number>
            <test-id>#{test_id}</test-id>
            <summary-marks available="20" obtained="13" />
          </mcq-test-result>
        </mcq-test-results>
      XML

      create(body: valid_xml)

      assert_response(201)
      assert_equal Result.where(test_id: test_id).count, 1
    end
  end
end
