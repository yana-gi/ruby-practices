# frozen_string_literal: true

require 'etc'

class LongFormatFile
  NUM_CONVERT_MAP = {
    0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx',
    4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx'
  }.freeze

  def initialize(file_path, file_name)
    @file_path = file_path
    @file_name = file_name
  end

  def stat
    @stat ||= File.lstat("#{@file_path}/#{@file_name}")
  end

  def format
    "#{filemode}#{permission} #{nlink} #{user}  #{group}  #{size} #{timestamp} #{@file_name}"
  end

  private

  def filemode
    case stat.ftype
    when 'directory'
      'd'
    when 'file'
      '-'
    end
  end

  def permission
    permit_nums = Kernel.format('%o', @stat.mode).match(/...$/).to_s.split('')
    permit_nums.inject('') { |permission, num| permission + NUM_CONVERT_MAP[num.to_i] }
  end

  def nlink
    @stat.nlink.to_s.rjust(2)
  end

  def user
    Etc.getpwuid(@stat.uid).name
  end

  def group
    Etc.getgrgid(@stat.gid).name
  end

  def size
    @stat.size.to_s
  end

  def timestamp
    @stat.mtime.strftime('%_m %_d %R')
  end
end
