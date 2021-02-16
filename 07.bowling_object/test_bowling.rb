# frozen_string_literal: true

require 'test/unit'
require './bowling'

class TestBowling < Test::Unit::TestCase
  def test_shot_score
    shot1 = Shot.new(1)
    shotx = Shot.new('X')
    assert_equal 1, shot1.score
    assert_equal 10, shotx.score
  end

  def test_frame_score
    frame_two = Flame.new('1', '2')
    frame_three = Flame.new('1', '2', '3')
    frame_strike = Flame.new('10', '0')
    assert_equal 3, frame_two.score
    assert_equal 6, frame_three.score
    assert_equal 10, frame_strike.score
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

  def test_game_score_sample
    game = Game.new('6390038273X9180XX64')
    assert_equal 150, game.score
  end

  def test_game_score_perfect
    game = Game.new('XXXXXXXXXXXX')
    assert_equal 300, game.score
  end

  def test_game_score_frames10isx5
    game = Game.new('XXXXXXXXXX5')
    assert_equal 280, game.score
  end

  def test_game_score_frame10isxx5
    game = Game.new('XXXXXXXXXXX5')
    assert_equal 295, game.score
  end

  def test_game_score_frame10isx37
    game = Game.new('XXXXXXXXXX37')
    assert_equal 283, game.score
  end

  def test_game_score_frame10is37x
    game = Game.new('XXXXXXXXX37X')
    assert_equal 273, game.score
  end

  def test_game_score_frame10is375
    game = Game.new('XXXXXXXXX375')
    assert_equal 268, game.score
  end
end
