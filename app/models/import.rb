class Import
  def self.parse(xml)
    new(Import::ParseXml.call(xml))
  end

  def initialize(data)
    @data = data
  end

  attr_reader :data

  def valid?
    !data.nil?
  end
end
