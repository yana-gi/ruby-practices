# frozen_string_literal: true

require 'test/unit'
require './bowling'

class TestBowling < Test::Unit::TestCase
  def test_shot_score
    assert_equal 1, Shot.new(1).score
    assert_equal 10, Shot.new('X').score
    assert_equal 0, Shot.new(nil).score

  end

  def test_frame_score
    assert_equal 3, Flame.new('1', '2').score
    assert_equal 6, Flame.new('1', '2', '3').score
    assert_equal 3, Flame.new('1', '2',nil).score
    assert_equal 10, Flame.new('10', '0').score
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
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,6,4')
    assert_equal 10, game.frames.count
  end

  def test_game_score_sample
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,6,4')
    assert_equal 150, game.score
  end

  def test_game_score_perfect
    game = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')
    assert_equal 300, game.score
  end

  def test_game_score_frames10isx5
    game = Game.new('X,X,X,X,X,X,X,X,X,X,5')
    assert_equal 280, game.score
  end

  def test_game_score_frame10isxx5
    game = Game.new('X,X,X,X,X,X,X,X,X,X,X,5')
    assert_equal 295, game.score
  end

  def test_game_score_frame10isx37
    game = Game.new('X,X,X,X,X,X,X,X,X,X,3,7')
    assert_equal 283, game.score
  end

  def test_game_score_frame10is37x
    game = Game.new('X,X,X,X,X,X,X,X,X,3,7,X')
    assert_equal 273, game.score
  end

  def test_game_score_frame10is375
    game = Game.new('X,X,X,X,X,X,X,X,X,3,7,5')
    assert_equal 268, game.score
  end
end
