# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/long_format_file'

class LongFormatFileTest < Minitest::Test
  def test_file_rows
    file_path = './test/lsDir'
    file_name = 'file_a.txt'
    assert_equal '-rw-r--r--  1 yana  staff  0  3  3 13:21 file_a.txt', LongFormatFile.new(file_path, file_name).row
  end

  def test_dir_rows
    file_path = './test/lsDir'
    file_name = 'Dir_a'
    assert_equal 'drwxr-xr-x  2 yana  staff  64  3  2 19:02 Dir_a', LongFormatFile.new(file_path, file_name).row
  end
end
