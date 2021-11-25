require 'dry/validation'

class Import::Contract < Dry::Validation::Contract
  params do
    required(:results).array(:hash) do
      required(:test_id).filled(:string)
      required(:student_number).filled(:string)
      required(:marks).hash do
        required(:obtained).filled(:integer)
        required(:available).filled(:integer)
      end
    end
  end
end
