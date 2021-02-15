# frozen_string_literal: true

class Shot
  attr_reader :mark, :score

  def initialize(mark)
    @mark = mark
    @score = calculate_score
  end

  def calculate_score
    @mark == 'X' ? 10 : @mark.to_i
  end
end
