# frozen_string_literal: true

require_relative '../lib/file_list'
require_relative '../lib/long_format_file'
require_relative '../lib/short_format_file'

class FormatFileList
  attr_reader :short_format_row_num, :file_list

  SHORT_FORMAT_COLUMN_NUM = 3

  def initialize(parameter)
    @parameter = parameter
  end

  def get
    @parameter.long_format? ? long_format_row_list : short_format_row_list
  end

  private

  def file_list
    @file_list ||= FileList.new(@parameter)
  end

  def short_format_row_list
    file_row_list = []

    file_list.get.each do |file|
      file_row = ShortFormatFile.new(@parameter.dir_path, file)
      file_row_list << file_row.format
    end

    transpose(file_row_list).join("\n")
  end

  def long_format_row_list
    file_row_list = []
    total_block = 0

    file_list.get.each do |file|
      file_row = LongFormatFile.new(@parameter.dir_path, file)
      file_row_list << file_row.format
      total_block += file_row.stat.blocks
    end

    file_row_list.unshift("total #{total_block}").join("\n")
  end

  def transpose(file_row_list)
    transposed_file_row_list = []
    short_format_row_num.times { transposed_file_row_list << '' }

    file_row_list.each_with_index do |name, idx|
      formated_name = name.ljust(@file_list.max_name_length + 2)
      row_idx = idx % short_format_row_num
      transposed_file_row_list[row_idx] += formated_name
    end

    transposed_file_row_list.map(&:strip)
  end

  def short_format_row_num
    @short_format_row_num ||= (@file_list.count.to_f / SHORT_FORMAT_COLUMN_NUM).ceil
  end
end
