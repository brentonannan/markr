class Import
  class InvalidImportError < RuntimeError; end

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

  def save!
    raise InvalidImportError, 'cannot save invalid Import' unless valid?

    ActiveRecord::Base.transaction do
      contract.values[:results].map do |result|
        ids = result.slice(:test_id, :student_number)
        Result.find_or_initialize_by(ids).tap do |record|
          record.update_marks(obtained_mark: result.dig(:marks, :obtained), available_marks: result.dig(:marks, :available))
          record.save!
        end
      end
    end
  end
end
