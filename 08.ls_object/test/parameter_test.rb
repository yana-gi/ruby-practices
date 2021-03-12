# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../lib/parameter'

class ParameterTest < MiniTest::Unit::TestCase
  DIR_PATH = './08.ls_object/test/sample_dir/lsDir'

  def test_dir_path
    option = { 'a' => false, 'r' => false, 'l' => false }
    assert_equal "#{Dir.pwd}/08.ls_object/test/sample_dir/lsDir", Parameter.new(DIR_PATH, option).dir_path
    assert_equal Dir.pwd, Parameter.new(nil, option).dir_path
  end

  def test_long_format?
    option = { 'a' => false, 'r' => false, 'l' => true }
    assert_equal true, Parameter.new(DIR_PATH, option).long_format?
  end

  def test_reverse?
    option = { 'a' => false, 'r' => true, 'l' => false }
    assert_equal true, Parameter.new(DIR_PATH, option).reverse?
  end

  def test_dot_match?
    option = { 'a' => true, 'r' => false, 'l' => false }
    assert_equal true, Parameter.new(DIR_PATH, option).dot_match?
  end
end
