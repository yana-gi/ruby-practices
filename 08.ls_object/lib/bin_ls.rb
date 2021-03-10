#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file_list'
require_relative '../lib/parameter'
require_relative '../lib/format_file_list'

require 'optparse'

option = ARGV.getopts('alr')
input_dir = ARGV[0]
parameter = Parameter.new(input_dir, option)

puts FormatFileList.new(parameter).get
