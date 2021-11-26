class Test::Statistics
  def initialize(test)
    @scores = test.results.map(&:score).sort
  end

  attr_reader :scores

  def mean
    @_mean ||= scores.sum.to_f / count
  end

  def min
    scores.first
  end

  def max
    scores.last
  end

  def count
    @_count ||= scores.length
  end

  def stddev
    @_stddev ||= Math.sqrt((scores.map { |score| (score - mean) ** 2 }.sum.to_f) / count)
  end

  def p(percentile)
    return min if percentile.zero?

    rank = count * percentile / 100.0
    index = rank.ceil - 1
    scores[index].to_f
  end

  def summary
    {
      mean: mean,
      stddev: stddev,
      min: min,
      max: max,
      p25: p(25),
      p50: p(50),
      p75: p(75),
      count: count
    }
  end
end
