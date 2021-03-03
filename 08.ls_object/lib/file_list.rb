# frozen_string_literal: true

require_relative 'short_format_file_list'
require_relative 'long_format_file_list'

class FileList
  def initialize(dir_path, options)
    @dir_path = dir_path
    @options = options
  end

  def puts
    format_file_list = @options['l'] ? LongFormatFileList.new(@dir_path, @options) : ShortFormatFileList.new(@dir_path, @options)
    format_file_list.rows
  end
end
