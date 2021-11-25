class ImportsController < ApplicationController
  CONTENT_TYPE = 'text/xml+markr'

  before_action :content_negotiation

  def create
    import = Import.parse(request.raw_post)
    return render(status: 400) if !import.valid?
  end

  private

  def content_negotiation
    render(status: 406) unless request.content_type == CONTENT_TYPE
  end
end
