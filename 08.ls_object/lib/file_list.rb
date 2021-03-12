# frozen_string_literal: true

require_relative '../lib/long_format_file'
require_relative '../lib/short_format_file'

class FileList
  def initialize(parameter)
    @parameter = parameter
  end

  def get
    files = @parameter.dot_match? ? Dir.glob("#{@parameter.dir_path}/*", File::FNM_DOTMATCH) : Dir.glob("#{@parameter.dir_path}/*")
    files = files.sort.map { |f| File.basename(f) }
    files = files.reverse if @parameter.reverse?
    files
  end

  def max_name_length
    @max_name_length ||= get.max_by(&:length).length
  end

  def count
    @count ||= get.count
  end
end
