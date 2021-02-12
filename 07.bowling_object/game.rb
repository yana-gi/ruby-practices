class Game
  GAME_FLAME_NUMBER = 10
  attr_accessor :result, :frames

  def initialize(result)
    @result = result
    @frames = result_to_frames
  end

  def result_to_frames
    results = @result.chars
    count = 0
    frames = []

    GAME_FLAME_NUMBER.times do |i|
      frame = []
      frame << results[count]

      if results[count] == 'X' && i != (GAME_FLAME_NUMBER - 1)
        count += 1
      else
        count += 1
        frame << results[count]
        count += 1
        frame << results[count] if i == (GAME_FLAME_NUMBER - 1)
      end
      frames << frame
    end
    frames.map do |i|
      Flame.new(i[0], i[1], i[2])
    end
  end

  def score
    point = 0
    @frames.each_with_index do |frame, i|
      point += frame.score
      break if i == (GAME_FLAME_NUMBER - 1)

      if frame.strike?
        point += @frames[i + 1].first_shot.score
        point += if @frames[i + 1].strike? && i != (GAME_FLAME_NUMBER - 2)
                   @frames[i + 2].first_shot.score
                 else
                   @frames[i + 1].second_shot.score
                 end
      elsif frame.spare?
        point += @frames[i + 1].first_shot.score
      end
    end
    point
  end
end
