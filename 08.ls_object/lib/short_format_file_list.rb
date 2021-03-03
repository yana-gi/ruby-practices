# frozen_string_literal: true

require_relative '../lib/short_format_file'

class ShortFormatFileList
  def initialize(dir_path)
    @dir_path = File.expand_path(dir_path || '')
  end

  def rows
    file_list = []
    Dir.foreach(@dir_path).sort.each do |file|
      next if file.start_with?('.')

      file_list << ShortFormatFile.new(@dir_path, file).row
    end

    formated_file_list(file_list).join("\n")
  end

  private

  def formated_file_list(file_list)
    formated_file_list = []
    row_num.times { formated_file_list << '' }

    file_list.each_with_index do |name, idx|
      formated_name = name.ljust(name_len_max)
      row_idx = idx % row_num

      formated_file_list[row_idx] += formated_name
    end

    formated_file_list
  end

  def name_len_max
    file_name_list = []
    Dir.foreach(@dir_path) { |f| file_name_list << f }
    file_name_list.max_by(&:length).length
  end

  def row_num
    file_name_list = []
    Dir.foreach(@dir_path) { |f| file_name_list << f }
    file_name_list.size / 8
  end
end
