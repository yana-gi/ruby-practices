# frozen_string_literal: true

require_relative '../lib/short_format_file'

class ShortFormatFileList
  def initialize(dir_path)
    @dir_path = File.expand_path(dir_path || '')
  end

  def row
    @file_list = []
    Dir.foreach(@dir_path).sort.each do |file|
      next if file.start_with?('.')
      @file_list << ShortFormatFile.new(@dir_path, file).row
    end

    @name_len_max = @file_list.max_by { |k, _v| k }[0].length
    @row_num = (@file_list.size * (@name_len_max + 2) / 10)

    @formated_file_list = []
    @row_num.times { @formated_file_list << [] }

    @file_list.each_with_index do |name, idx|
      formated_name = name.ljust(@name_len_max + 2)
      row_idx = idx % @row_num

      @formated_file_list[row_idx].push(formated_name)
    end

    @formated_file_list
  end
end
