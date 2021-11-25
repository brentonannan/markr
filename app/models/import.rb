class Import
  def initialize(data)
    @data = data
  end

  attr_reader :data

  def valid?
    !data.nil?
  end
end
