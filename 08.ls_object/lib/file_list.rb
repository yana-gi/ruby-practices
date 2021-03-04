# frozen_string_literal: true

require_relative '../lib/long_format_file'
require_relative '../lib/short_format_file'

class FileList
  SHORT_FORMAT_ROW_NUM = 3

  def initialize(dir_path, options)
    @dir_path = File.expand_path(dir_path || '')
    @options = options
  end

  def puts
    @options['l'] ? long_rows : short_rows
  end

  def short_rows
    file_list = []
    Dir.foreach(@dir_path).sort.each do |file|
      next if file.start_with?('.') && !@options['a']

      format_file = ShortFormatFile.new(@dir_path, file)
      file_list << format_file.row
    end

    file_list = file_list.reverse if @options['r']
    file_list = formated_file_list(file_list)
    file_list.join("\n")
  end

  def long_rows
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

  private

  def formated_file_list(file_list)
    formated_file_list = []
    SHORT_FORMAT_ROW_NUM.times { formated_file_list << '' }

    file_list.each_with_index do |name, idx|
      formated_name = name.ljust(name_len_max + 2)
      row_idx = idx % SHORT_FORMAT_ROW_NUM

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
