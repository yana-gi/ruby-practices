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
end
