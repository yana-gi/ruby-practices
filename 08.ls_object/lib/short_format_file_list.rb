# frozen_string_literal: true

require_relative '../lib/short_format_file'

class ShortFormatFileList
  ROW_NUM = 3

  def initialize(dir_path, options)
    @dir_path = File.expand_path(dir_path || '')
    @options = options
  end

  def rows
    file_list = []
    Dir.foreach(@dir_path).sort.each do |file|
      next if file.start_with?('.') && !@options['a']

      file_list << ShortFormatFile.new(@dir_path, file).row
    end

    formated_file_list(file_list).join("\n")
  end

  private

  def formated_file_list(file_list)
    formated_file_list = []
    ROW_NUM.times { formated_file_list << '' }

    file_list = file_list.reverse if @options['r']

    file_list.each_with_index do |name, idx|
      formated_name = name.ljust(name_len_max + 2)
      row_idx = idx % ROW_NUM

      formated_file_list[row_idx] += formated_name
    end
    formated_file_list.map(&:strip)
  end

  def name_len_max
    file_name_list = []
    Dir.foreach(@dir_path) { |f| file_name_list << f }
    file_name_list.max_by(&:length).length
  end
end
