# frozen_string_literal: true

require './flame'

class Game
  NUM_FLAMES = 10
  attr_reader :frames

  def initialize(result)
    @frames = create_frames(result.chars)
  end

  def create_frames(results)
    count = 0
    frames = []

    NUM_FLAMES.times do |i|
      second_shot, third_shot = 0
      first_shot = results[count]
      second_shot = results[count += 1] if first_shot != 'X' || i == (NUM_FLAMES - 1)
      third_shot = results[count += 1] if i == (NUM_FLAMES - 1)
      frames << Flame.new(first_shot, second_shot, third_shot)
      count += 1
    end

    frames
  end

  def score
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
