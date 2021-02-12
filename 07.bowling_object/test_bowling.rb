require 'test/unit'
require './bowling'

class TestBowling < Test::Unit::TestCase
  def test_shot_is_1_mark
    shot = Shot.new(1)
    assert_equal 1, shot.mark
  end

  def test_shot_is_1_score
    shot = Shot.new(1)
    assert_equal 1, shot.score
  end

  def test_shot_is_x_score
    shot = Shot.new('X')
    assert_equal 10, shot.score
  end

  def test_frame_shot_count_is_2
    frame = Flame.new('1', '2')
    assert_equal 3, frame.score
  end

  def test_frame_shot_count_is_3
    frame = Flame.new('1', '2', '3')
    assert_equal 6, frame.score
  end

  def test_frame_shot_is_strike
    frame = Flame.new('10', '0')
    assert_equal 10, frame.score
  end
end
