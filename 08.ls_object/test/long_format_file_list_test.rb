# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/long_format_file_list'

class LongFormatFileListTest < MiniTest::Unit::TestCase
  def test_file_row_list
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
    dir_path = './08.ls_object/test/sample_dir/lsDir'
    options = { 'a' => false, 'r' => false, 'l' => true }
    assert_equal expected, LongFormatFileList.new(dir_path, options).rows
  end
end
