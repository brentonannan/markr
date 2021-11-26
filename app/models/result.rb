class Result < ApplicationRecord
  after_initialize do
    self.obtained_mark ||= 0
    self.available_marks ||= 0
  end

  def update_marks(obtained_mark:, available_marks:)
    # Note: Assumes data has been validated.
    self.obtained_mark = [self.obtained_mark, obtained_mark].max
    self.available_marks = [self.available_marks, available_marks].max
  end

  def score
    Rational(obtained_mark, available_marks)
  end
end
