#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file_list'

require 'optparse'

params = ARGV.getopts('alr')
input_dir = ARGV[0]
params = { long_format: params['l'],
           reverse: params['r'],
           dot_match: params['a']
}

puts FileList.new(input_dir, params).load
