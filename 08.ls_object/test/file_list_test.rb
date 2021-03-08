# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/file_list'

class FileListTest < MiniTest::Unit::TestCase
  DIR_PATH = './08.ls_object/test/sample_dir/lsDir'

  def test_no_option
    expected = <<~TEXT.chomp
      Dir_a       file_a.txt  file_c.txt
      Dir_b       file_b.txt  file_d.txt
    TEXT
    params = { 'a' => false, 'r' => false, 'l' => false }
    assert_equal expected, FileList.new(DIR_PATH, params).load
  end

  def test_option_dot_match
    expected = <<~TEXT.chomp
      .            .file_B.txt  file_a.txt
      ..           .file_C.txt  file_b.txt
      .Dir_A       .file_D.txt  file_c.txt
      .Dir_B       Dir_a        file_d.txt
      .file_A.txt  Dir_b
    TEXT
    params = { 'a' => true, 'r' => false, 'l' => false }
    assert_equal expected, FileList.new(DIR_PATH, params).load
  end

  def test_reverse
    expected = <<~TEXT.chomp
      file_d.txt  file_b.txt  Dir_b
      file_c.txt  file_a.txt  Dir_a
    TEXT
    params = { 'a' => false, 'r' => true, 'l' => false }
    assert_equal expected, FileList.new(DIR_PATH, params).load
  end

  def test_reverse_dot_match
    expected = <<~TEXT.chomp
      file_d.txt   Dir_a        .Dir_B
      file_c.txt   .file_D.txt  .Dir_A
      file_b.txt   .file_C.txt  ..
      file_a.txt   .file_B.txt  .
      Dir_b        .file_A.txt
    TEXT
    params = { 'a' => true, 'r' => true, 'l' => false }
    assert_equal expected, FileList.new(DIR_PATH, params).load
  end

  def test_option_long
    expected = <<~TEXT.chomp
      total 0
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_a
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_b
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_a.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_b.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_c.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_d.txt
    TEXT
    params = { 'a' => false, 'r' => false, 'l' => true }
    assert_equal expected, FileList.new(DIR_PATH, params).load
  end

  def test_option_long_and_dot_match
    expected = <<~TEXT.chomp
      total 0
      drwxr-xr-x 14 yana  staff  448  3  8 19:17 .
      drwxr-xr-x  4 yana  staff  128  3  8 19:14 ..
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 .Dir_A
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 .Dir_B
      -rw-r--r--  1 yana  staff  0  3  3 17:26 .file_A.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 .file_B.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 .file_C.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 .file_D.txt
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_a
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_b
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_a.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_b.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_c.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_d.txt
    TEXT
    params = { 'a' => true, 'r' => false, 'l' => true }
    assert_equal expected, FileList.new(DIR_PATH, params).load
  end

  def test_option_long_and_reverse
    expected = <<~TEXT.chomp
      total 0
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_d.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_c.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_b.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_a.txt
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_b
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_a
    TEXT
    params = { 'a' => false, 'r' => true, 'l' => true }
    assert_equal expected, FileList.new(DIR_PATH, params).load
  end

  def test_option_long_and_reverse_and_dot_match
    expected = <<~TEXT.chomp
      total 0
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_d.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_c.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_b.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_a.txt
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_b
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_a
      -rw-r--r--  1 yana  staff  0  3  3 17:26 .file_D.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 .file_C.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 .file_B.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 .file_A.txt
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 .Dir_B
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 .Dir_A
      drwxr-xr-x  4 yana  staff  128  3  8 19:14 ..
      drwxr-xr-x 14 yana  staff  448  3  8 19:17 .
    TEXT
    params = { 'a' => true, 'r' => true, 'l' => true }
    assert_equal expected, FileList.new(DIR_PATH, params).load
  end
end
