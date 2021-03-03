# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/file_list'

class FileListTest < MiniTest::Unit::TestCase
  def test_no_option
    expected = <<~TEXT.chomp
      Dir_a         file_a.txt    file_c.txt    hd_lnk_cal.rb 
      Dir_b         file_b.txt    file_d.txt    sym_lnk_cal.rb
    TEXT
    dir_path = './08.ls_object/test/lsDir'
    options = { 'a' => false, 'r' => false, 'l' => false }
    assert_equal expected, FileList.new(dir_path, options).puts
  end

  def test_long_option
    expected = <<~TEXT.chomp
      drwxr-xr-x  2 yana  staff  64  3  2 19:02 Dir_a
      drwxr-xr-x  2 yana  staff  64  3  2 19:02 Dir_b
      -rw-r--r--  1 yana  staff  0  3  3 13:21 file_a.txt
      -rw-r--r--  1 yana  staff  0  3  3 13:21 file_b.txt
      -rw-r--r--  1 yana  staff  0  3  3 13:21 file_c.txt
      -rw-r--r--  1 yana  staff  0  3  3 13:21 file_d.txt
      -rwxr--r--  1 yana  staff  1477  8  6 18:14 hd_lnk_cal.rb
      -rwxr--r--  1 yana  staff  1477  8  6 18:14 sym_lnk_cal.rb
    TEXT
    dir_path = './08.ls_object/test/lsDir'
    options = { 'a' => false, 'r' => false, 'l' => true }
    assert_equal expected, FileList.new(dir_path, options).puts
  end
end
