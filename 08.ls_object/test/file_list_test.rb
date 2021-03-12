# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/file_list'
require_relative '../lib/parameter'

class FormatFileListTest < MiniTest::Unit::TestCase
  DIR_PATH = './08.ls_object/test/sample_dir/lsDir'

  def test_get_no_option
    expected = %w[Dir_a Dir_b file_a.txt file_b.txt file_c.txt file_d.txt]
    option = { 'a' => false, 'r' => false, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FileList.new(parameter).get
  end

  def test_get_dot_match
    expected = %w[. .. .Dir_A .Dir_B .file_A.txt .file_B.txt .file_C.txt .file_D.txt Dir_a Dir_b file_a.txt file_b.txt file_c.txt file_d.txt]
    option = { 'a' => true, 'r' => false, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FileList.new(parameter).get
  end

  def test_get_reverse
    expected = %w[file_d.txt file_c.txt file_b.txt file_a.txt Dir_b Dir_a]
    option = { 'a' => false, 'r' => true, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FileList.new(parameter).get
  end

  def test_get_dot_match_and_reverse
    expected = %w[file_d.txt file_c.txt file_b.txt file_a.txt Dir_b Dir_a .file_D.txt .file_C.txt .file_B.txt .file_A.txt .Dir_B .Dir_A .. .]
    option = { 'a' => true, 'r' => true, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FileList.new(parameter).get
  end

  def test_max_name_length
    option = { 'a' => false, 'r' => false, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal 10, FileList.new(parameter).max_name_length

    option = { 'a' => true, 'r' => false, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal 11, FileList.new(parameter).max_name_length
  end

  def test_count
    option = { 'a' => false, 'r' => false, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal 6, FileList.new(parameter).count

    option = { 'a' => true, 'r' => false, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal 14, FileList.new(parameter).count
  end
end
