class Test
  def self.find(id)
    new(Result.where(test_id: id))
  end

  def initialize(results)
    @results = results
  end

  attr_reader :results
end
