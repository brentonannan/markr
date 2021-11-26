class Test::StatisticsController < ApplicationController
  def show
    test = Test.find(params[:test_id])
    return render(status: 404) if test.results.empty?

    stats = Test::Statistics.new(test)
    render(body: stats.summary.to_json)
  end
end
