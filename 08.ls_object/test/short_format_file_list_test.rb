# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/short_format_file_list'

class ShortFormatFileListTest < MiniTest::Unit::TestCase
  def test_rows
    expected = <<~TEXT.chomp
      Dir_a         file_b.txt    hd_lnk_cal.rb
      Dir_b         file_c.txt    sym_lnk_cal.rb
      file_a.txt    file_d.txt
    TEXT
    dir_path =   './08.ls_object/test/sample_dir/lsDir'
    options = { 'a' => false, 'r' => false, 'l' => true }

    assert_equal expected, ShortFormatFileList.new(dir_path, options).rows
  end
end
