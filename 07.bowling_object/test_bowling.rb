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

  def test_frame_second_shot
    frame = Flame.new('1', '2')
    assert_equal 3, frame.score
  end

  def test_frame_third_shot
    frame = Flame.new('1', '2', '3')
    assert_equal 6, frame.score
  end

  def test_frame_is_strike
    frame = Flame.new('10', '0')
    assert_equal 10, frame.score
  end

  def test_frame_strike?
    frame = Flame.new('10', '0')
    assert frame.strike?
    assert !frame.spare?
  end

  def test_frame_spare?
    frame = Flame.new('2', '8')
    assert frame.spare?
    assert !frame.strike?
  end

  def test_game_frames_count
    game = Game.new('6390038273X9180XX64')
    assert_equal 10, game.frames.count
  end

  def test_game_frames_sample
    game = Game.new('6390038273X9180XX64')
    assert_equal 150, game.score
  end

  def test_game_frames_10_is_x5
    game = Game.new('XXXXXXXXXX5')
    assert_equal 280, game.score
  end

  def test_game_frames_10_is_xx5
    game = Game.new('XXXXXXXXXXX5')
    assert_equal 295, game.score
  end

  def test_game_frames_10_is_x37
    game = Game.new('XXXXXXXXXX37')
    assert_equal 283, game.score
  end

  def test_game_frames_10_is_37x
    game = Game.new('XXXXXXXXX37X')
    assert_equal 273, game.score
  end

  def test_game_frames_perfect
    game = Game.new('XXXXXXXXXXXX')
    assert_equal 300, game.score
  end

  def test_game_frames_10_is_375
    game = Game.new('XXXXXXXXX375')
    assert_equal 268, game.score
  end

end
