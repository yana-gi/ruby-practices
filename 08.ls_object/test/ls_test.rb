# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/bin_ls'

class LsTest < Minitest::Test
  TARGET_PATHNAME = Pathname('test/lsDir')
  def test_path
    assert_equal 'test/lsDir', TARGET_PATHNAME.to_s
  end
end
