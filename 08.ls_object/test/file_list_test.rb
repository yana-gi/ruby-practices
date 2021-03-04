# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/file_list'

class FileListTest < MiniTest::Unit::TestCase
  DIR_PATH = './08.ls_object/test/sample_dir/lsDir'

  def test_no_option
    expected = <<~TEXT.chomp
      Dir_a           file_b.txt      hd_lnk_cal.rb
      Dir_b           file_c.txt      sym_lnk_cal.rb
      file_a.txt      file_d.txt
    TEXT
    options = { 'a' => false, 'r' => false, 'l' => false }
    assert_equal expected, FileList.new(DIR_PATH, options).load
  end

  def test_option_dot_match
    expected = <<~TEXT.chomp
      .               .Dir_B          .file_C.txt     Dir_b           file_c.txt      sym_lnk_cal.rb
      ..              .file_A.txt     .file_D.txt     file_a.txt      file_d.txt
      .Dir_A          .file_B.txt     Dir_a           file_b.txt      hd_lnk_cal.rb
    TEXT
    options = { 'a' => true, 'r' => false, 'l' => false }
    assert_equal expected, FileList.new(DIR_PATH, options).load
  end

  def test_reverse
    expected = <<~TEXT.chomp
      sym_lnk_cal.rb  file_c.txt      Dir_b
      hd_lnk_cal.rb   file_b.txt      Dir_a
      file_d.txt      file_a.txt
    TEXT
    options = { 'a' => false, 'r' => true, 'l' => false }
    assert_equal expected, FileList.new(DIR_PATH, options).load
  end

  def test_reverse_dot_match
    expected = <<~TEXT.chomp
      sym_lnk_cal.rb  file_c.txt      Dir_b           .file_C.txt     .Dir_B          .
      hd_lnk_cal.rb   file_b.txt      Dir_a           .file_B.txt     .Dir_A
      file_d.txt      file_a.txt      .file_D.txt     .file_A.txt     ..
    TEXT
    options = { 'a' => true, 'r' => true, 'l' => false }
    assert_equal expected, FileList.new(DIR_PATH, options).load
  end

  def test_option_long
    expected = <<~TEXT.chomp
      total 16
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_a
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_b
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_a.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_b.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_c.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_d.txt
      -rwxr--r--  1 yana  staff  1477  3  3 17:26 hd_lnk_cal.rb
      -rwxr--r--  1 yana  staff  1477  3  3 17:26 sym_lnk_cal.rb
    TEXT
    options = { 'a' => false, 'r' => false, 'l' => true }
    assert_equal expected, FileList.new(DIR_PATH, options).load
  end

  def test_option_long_and_dot_match
    expected = <<~TEXT.chomp
      total 16
      drwxr-xr-x 16 yana  staff  512  3  2 19:03 .
      drwxr-xr-x  3 yana  staff  96  3  3 17:46 ..
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
      -rwxr--r--  1 yana  staff  1477  3  3 17:26 hd_lnk_cal.rb
      -rwxr--r--  1 yana  staff  1477  3  3 17:26 sym_lnk_cal.rb
    TEXT
    options = { 'a' => true, 'r' => false, 'l' => true }
    assert_equal expected, FileList.new(DIR_PATH, options).load
  end

  def test_option_long_and_reverse
    expected = <<~TEXT.chomp
      total 16
      -rwxr--r--  1 yana  staff  1477  3  3 17:26 sym_lnk_cal.rb
      -rwxr--r--  1 yana  staff  1477  3  3 17:26 hd_lnk_cal.rb
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_d.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_c.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_b.txt
      -rw-r--r--  1 yana  staff  0  3  3 17:26 file_a.txt
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_b
      drwxr-xr-x  2 yana  staff  64  3  3 17:26 Dir_a
    TEXT
    options = { 'a' => false, 'r' => true, 'l' => true }
    assert_equal expected, FileList.new(DIR_PATH, options).load
  end

  def test_option_long_and_reverse_and_dot_match
    expected = <<~TEXT.chomp
      total 16
      -rwxr--r--  1 yana  staff  1477  3  3 17:26 sym_lnk_cal.rb
      -rwxr--r--  1 yana  staff  1477  3  3 17:26 hd_lnk_cal.rb
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
      drwxr-xr-x  3 yana  staff  96  3  3 17:46 ..
      drwxr-xr-x 16 yana  staff  512  3  2 19:03 .
    TEXT
    options = { 'a' => true, 'r' => true, 'l' => true }
    assert_equal expected, FileList.new(DIR_PATH, options).load
  end
end
