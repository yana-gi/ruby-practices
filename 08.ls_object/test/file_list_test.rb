# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/format_file_list'
require_relative '../lib/parameter'

class FileListTest < MiniTest::Unit::TestCase
  DIR_PATH = './08.ls_object/test/sample_dir/lsDir'

  def test_no_option
    expected = <<~TEXT.chomp
      Dir_a       file_a.txt  file_c.txt
      Dir_b       file_b.txt  file_d.txt
    TEXT
    option = { 'a' => false, 'r' => false, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FormatFileList.new(parameter).get
  end

  def test_option_dot_match
    expected = <<~TEXT.chomp
      .            .file_B.txt  file_a.txt
      ..           .file_C.txt  file_b.txt
      .Dir_A       .file_D.txt  file_c.txt
      .Dir_B       Dir_a        file_d.txt
      .file_A.txt  Dir_b
    TEXT
    option = { 'a' => true, 'r' => false, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FormatFileList.new(parameter).get
  end

  def test_reverse
    expected = <<~TEXT.chomp
      file_d.txt  file_b.txt  Dir_b
      file_c.txt  file_a.txt  Dir_a
    TEXT
    option = { 'a' => false, 'r' => true, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FormatFileList.new(parameter).get
  end

  def test_reverse_dot_match
    expected = <<~TEXT.chomp
      file_d.txt   Dir_a        .Dir_B
      file_c.txt   .file_D.txt  .Dir_A
      file_b.txt   .file_C.txt  ..
      file_a.txt   .file_B.txt  .
      Dir_b        .file_A.txt
    TEXT
    option = { 'a' => true, 'r' => true, 'l' => false }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FormatFileList.new(parameter).get
  end

  def test_option_long
    expected = <<~TEXT.chomp
      total 32
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_a
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_b
      -rw-r--r--  1 yana  staff  5  3  9 17:52 file_a.txt
      -rw-r--r--  1 yana  staff  14  3  9 17:52 file_b.txt
      -rw-r--r--  1 yana  staff  27  3  9 17:52 file_c.txt
      -rw-r--r--  1 yana  staff  44  3  9 17:52 file_d.txt
    TEXT
    option = { 'a' => false, 'r' => false, 'l' => true }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FormatFileList.new(parameter).get
  end

  def test_option_long_and_dot_match
    expected = <<~TEXT.chomp
      total 64
      drwxr-xr-x 14 yana  staff  448  3  9 17:52 .
      drwxr-xr-x  4 yana  staff  128  3  8 19:14 ..
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 .Dir_A
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 .Dir_B
      -rw-r--r--  1 yana  staff  5  3  9 17:52 .file_A.txt
      -rw-r--r--  1 yana  staff  14  3  9 17:52 .file_B.txt
      -rw-r--r--  1 yana  staff  27  3  9 17:52 .file_C.txt
      -rw-r--r--  1 yana  staff  44  3  9 17:52 .file_D.txt
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_a
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_b
      -rw-r--r--  1 yana  staff  5  3  9 17:52 file_a.txt
      -rw-r--r--  1 yana  staff  14  3  9 17:52 file_b.txt
      -rw-r--r--  1 yana  staff  27  3  9 17:52 file_c.txt
      -rw-r--r--  1 yana  staff  44  3  9 17:52 file_d.txt
    TEXT
    option = { 'a' => true, 'r' => false, 'l' => true }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FormatFileList.new(parameter).get
  end

  def test_option_long_and_reverse
    expected = <<~TEXT.chomp
      total 32
      -rw-r--r--  1 yana  staff  44  3  9 17:52 file_d.txt
      -rw-r--r--  1 yana  staff  27  3  9 17:52 file_c.txt
      -rw-r--r--  1 yana  staff  14  3  9 17:52 file_b.txt
      -rw-r--r--  1 yana  staff  5  3  9 17:52 file_a.txt
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_b
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_a
    TEXT
    option = { 'a' => false, 'r' => true, 'l' => true }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FormatFileList.new(parameter).get
  end

  def test_option_long_and_reverse_and_dot_match
    expected = <<~TEXT.chomp
      total 64
      -rw-r--r--  1 yana  staff  44  3  9 17:52 file_d.txt
      -rw-r--r--  1 yana  staff  27  3  9 17:52 file_c.txt
      -rw-r--r--  1 yana  staff  14  3  9 17:52 file_b.txt
      -rw-r--r--  1 yana  staff  5  3  9 17:52 file_a.txt
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_b
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_a
      -rw-r--r--  1 yana  staff  44  3  9 17:52 .file_D.txt
      -rw-r--r--  1 yana  staff  27  3  9 17:52 .file_C.txt
      -rw-r--r--  1 yana  staff  14  3  9 17:52 .file_B.txt
      -rw-r--r--  1 yana  staff  5  3  9 17:52 .file_A.txt
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 .Dir_B
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 .Dir_A
      drwxr-xr-x  4 yana  staff  128  3  8 19:14 ..
      drwxr-xr-x 14 yana  staff  448  3  9 17:52 .
    TEXT
    option = { 'a' => true, 'r' => true, 'l' => true }
    parameter = Parameter.new(DIR_PATH, option)
    assert_equal expected, FormatFileList.new(parameter).get
  end
end
