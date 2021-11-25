require 'test_helper'

class ImportTest < ActiveSupport::TestCase
  describe '#valid?' do
    it 'returns false if data is nil' do
      refute Import.new(nil).valid?
    end
  end
end
