# frozen_string_literal: true

require_relative '../lib/long_format_file'

class LongFormatFileList
  def initialize(dir_path, options)
    @dir_path = File.expand_path(dir_path || '')
    @options = options
  end

  def rows
    file_list = []
    total_block = 0

    Dir.foreach(@dir_path).sort.each do |file|
      next if file.start_with?('.') && !@options['a']

      format_file = LongFormatFile.new(@dir_path, file)
      file_list << format_file.row
      total_block += format_file.stat.blocks
    end

    file_list = file_list.reverse if @options['r']
    file_list.unshift("total #{total_block}")
    file_list.join("\n")
  end
end
