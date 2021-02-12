class Shot
  attr_accessor :mark

  def initialize(mark)
    @mark = mark
  end

  def score
    if @mark == 'X'
      10
    else
      @mark.to_i
    end
  end
end
