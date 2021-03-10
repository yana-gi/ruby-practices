# frozen_string_literal: true

class Parameter
  attr_reader :dir_path

  def initialize(dir_path, option)
    @dir_path = File.expand_path(dir_path || '')
    @option = option
  end

  def long_format?
    @option['l']
  end

  def reverse?
    @option['r']
  end

  def dot_match?
    @option['a']
  end
end
