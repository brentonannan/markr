require 'test_helper'

class ImportsControllerTest < ActionDispatch::IntegrationTest
  def create(body: nil, content_type: ImportsController::CONTENT_TYPE)
    post imports_path, env: {'RAW_POST_DATA' => body}, headers: {'Content-Type' => content_type}
  end

  describe '#create' do
    it 'returns a 406 for invalid content-types' do
      ['text/xml', 'application/xml', 'text/html'].each do |content_type|
        create(content_type: content_type)

        assert_response(406)
      end
    end
  end
end
