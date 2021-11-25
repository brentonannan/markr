class Import
  def self.parse(xml)
    new(Import::ParseXml.call(xml))
  end

  def initialize(data, contract: nil)
    @contract = contract || Contract.new.call(data)
  end

  attr_reader :contract

  def valid?
    contract.success?
  end
end
