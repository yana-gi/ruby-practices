# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/short_format_file'

class ShortFormatFileTest < Minitest::Test
  def test_file_put
    file_path = './test/lsDir'
    file_name = 'file_a.txt'
    assert_equal 'file_a.txt', ShortFormatFile.new(file_path, file_name).format
  end

  def test_dir_put
    file_path = './test/lsDir'
    file_name = 'Dir_a'
    assert_equal 'Dir_a', ShortFormatFile.new(file_path, file_name).format
  end
end
