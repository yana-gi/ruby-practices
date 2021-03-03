# frozen_string_literal: true

require_relative '../lib/long_format_file'

class LongFormatFileList
  def initialize(dir_path)
    @dir_path = File.expand_path(dir_path || '')
  end

  def rows
    file_list = []
    Dir.foreach(@dir_path).sort.each do |file|
      next if file.start_with?('.')

      file_list << LongFormatFile.new(@dir_path, file).row
    end
    file_list.join("\n")
  end
end
