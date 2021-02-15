# frozen_string_literal: true

class Game
  NUM_FLAMES = 10
  attr_reader :frames, :score

  def initialize(result)
    @frames = create_frames(result.chars)
    @score = calculate_score
  end

  def create_frames(results)
    count = 0
    frames = []

    NUM_FLAMES.times do |i|
      frame = []
      frame << results[count]

      if results[count] == 'X' && i != (NUM_FLAMES - 1)
        count += 1
      else
        count += 1
        frame << results[count]
        count += 1
        frame << results[count] if i == (NUM_FLAMES - 1)
      end
      frames << frame
    end

    frames.map do |frame|
      Flame.new(frame[0], frame[1], frame[2])
    end
  end

  def calculate_score
    point = 0
    NUM_FLAMES.times do |i|
      point += @frames[i].score
      # 10フレーム目はストライク・スペアの計算をしない
      break if i == (NUM_FLAMES - 1)

      if @frames[i].strike?
        point += @frames[i + 1].first_shot.score
        # 次のフレームがストライクの場合はその次のフレームを加算（9フレーム目の場合を除く）
        point += if @frames[i + 1].strike? && i != (NUM_FLAMES - 2)
                   @frames[i + 2].first_shot.score
                 else
                   @frames[i + 1].second_shot.score
                 end
      elsif @frames[i].spare?
        point += @frames[i + 1].first_shot.score
      end
    end
    point
  end
end
