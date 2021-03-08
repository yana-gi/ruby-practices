# frozen_string_literal: true

require_relative '../lib/long_format_file'
require_relative '../lib/short_format_file'

class FileList
  SHORT_FORMAT_COLUMN_NUM = 3

  def initialize(dir_path, params)
    @dir_path = File.expand_path(dir_path || '')
    @params = params
  end

  def load
    long_format? ? long_format_row_list : short_format_row_list
  end

  private

  def long_format?
    @params[:long_format]
  end

  def reverse?
    @params[:reverse]
  end

  def dot_match?
    @params[:dot_match]
  end

  def short_format_row_list
    file_row_list = []
    Dir.foreach(@dir_path).sort.each do |file|
      next if file.start_with?('.') && !dot_match?

      file_row = ShortFormatFile.new(@dir_path, file)
      file_row_list << file_row.format
    end

    file_row_list = file_row_list.reverse if reverse?
    file_row_list = transpose(file_row_list)
    file_row_list.join("\n")
  end

  def long_format_row_list
    file_row_list = []
    total_block = 0

    Dir.foreach(@dir_path).sort.each do |file|
      next if file.start_with?('.') && !dot_match?

      file_row = LongFormatFile.new(@dir_path, file)
      file_row_list << file_row.format
      total_block += file_row.stat.blocks
    end

    file_row_list = file_row_list.reverse if reverse?
    file_row_list.unshift("total #{total_block}")
    file_row_list.join("\n")
  end

  def transpose(file_row_list)
    transposed_file_row_list = []
    short_format_row_num.times { transposed_file_row_list << '' }

    file_row_list.each_with_index do |name, idx|
      formated_name = name.ljust(name_max_length + 2)
      row_idx = idx % short_format_row_num

      transposed_file_row_list[row_idx] += formated_name
    end
    transposed_file_row_list.map(&:strip)
  end

  def short_format_row_num
    files = dot_match? ? Dir.glob("#{@dir_path}/*", File::FNM_DOTMATCH) : Dir.glob("#{@dir_path}/*")
    files.count / SHORT_FORMAT_COLUMN_NUM + 1
  end

  def name_max_length
    file_name_list = []
    Dir.foreach(@dir_path) { |f| file_name_list << f }
    file_name_list.max_by(&:length).length
  end
end
