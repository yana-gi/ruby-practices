# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/long_format_file_list'

class LongFormatFileListTest < MiniTest::Unit::TestCase
  def test_file_row_list
    expected = <<~TEXT.chomp
      drwxr-xr-x  2 yana  staff    64  3  2 19:02 Dir_a
      drwxr-xr-x  2 yana  staff    64  3  2 19:02 Dir_b
      -rw-r--r--  1 yana  staff     0  3  3 13:21 file_a.txt
      -rw-r--r--  1 yana  staff     0  3  3 13:21 file_b.txt
      -rw-r--r--  1 yana  staff     0  3  3 13:21 file_c.txt
      -rw-r--r--  1 yana  staff     0  3  3 13:21 file_d.txt
      -rwxr--r--  1 yana  staff  1477  8  6  2020 hd_lnk_cal.rb
      -rwxr--r--  1 yana  staff  1477  8  6  2020 sym_lnk_cal.rb
    TEXT
    dir_path = './08.ls_object/test/lsDir'
    assert_equal 8, LongFormatFileList.new(dir_path).rows.count
  end
end
