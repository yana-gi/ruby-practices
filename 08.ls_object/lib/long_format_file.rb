# frozen_string_literal: true

class LongFormatFile
  attr_reader :stat

  NUM_CONVERT_MAP = {
    0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx',
    4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx'
  }.freeze

  def initialize(file_path, file_name)
    @file_path = file_path
    @file_name = file_name
    @file_full_path = "#{file_path}/#{file_name}"
    @stat = File.lstat(@file_full_path)
  end

  def format
    "#{filemode}#{permission} #{nlink} #{user}  #{group}  #{size} #{timestamp} #{filename}"
  end

  private

  def filemode
    if FileTest.symlink?(@file_full_path)
      'l'
    elsif @stat.ftype == 'directory'
      'd'
    elsif @stat.ftype == 'file'
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

  def filename
    if FileTest.symlink?(@file_full_path)
      "#{@file_name} -> #{File.readlink(@file_full_path)}"
    else
      @file_name
    end
  end
end
