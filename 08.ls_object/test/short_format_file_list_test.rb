# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/short_format_file_list'

class ShortFormatFileListTest < MiniTest::Unit::TestCase
  def test_rows
    expected = <<~TEXT.chomp
      Dir_a         file_a.txt    file_c.txt    hd_lnk_cal.rb 
      Dir_b         file_b.txt    file_d.txt    sym_lnk_cal.rb
    TEXT
    dir_path = './08.ls_object/test/lsDir'
    assert_equal expected, ShortFormatFileList.new(dir_path).rows
  end
end
