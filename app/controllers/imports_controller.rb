class ImportsController < ApplicationController
  CONTENT_TYPE = 'text/xml+markr'

  before_action :content_negotiation

  def create
    data = Import::ParseXml.call(request.raw_post)
    return render(status: 400) if data.nil?
  end

  private

  def content_negotiation
    render(status: 406) unless request.content_type == CONTENT_TYPE
  end
end
