#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file_list'

require 'optparse'

params = ARGV.getopts('alr')
input_dir = ARGV[0]

puts FileList.new(input_dir, params).load
