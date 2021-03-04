# frozen_string_literal: true

require_relative '../lib/long_format_file'
require_relative '../lib/short_format_file'

class FileList
  SHORT_FORMAT_ROW_NUM = 3

  def initialize(dir_path, params)
    @dir_path = File.expand_path(dir_path || '')
    @params = params
  end

  def load
    @params[:long_format] ? long_format_row_list : short_format_row_list
  end

  private

  def short_format_row_list
    file_row_list = []
    Dir.foreach(@dir_path).sort.each do |file|
      next if file.start_with?('.') && !@params[:dot_match]

      file_row = ShortFormatFile.new(@dir_path, file)
      file_row_list << file_row.format
    end

    file_row_list = file_row_list.reverse if @params[:reverse]
    file_row_list = transpose(file_row_list)
    file_row_list.join("\n")
  end

  def long_format_row_list
    file_row_list = []
    total_block = 0

    Dir.foreach(@dir_path).sort.each do |file|
      next if file.start_with?('.') && !@params[:dot_match]

      file_row = LongFormatFile.new(@dir_path, file)
      file_row_list << file_row.format
      total_block += file_row.stat.blocks
    end

    file_row_list = file_row_list.reverse if @params[:reverse]
    file_row_list.unshift("total #{total_block}")
    file_row_list.join("\n")
  end

  def transpose(file_list)
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
