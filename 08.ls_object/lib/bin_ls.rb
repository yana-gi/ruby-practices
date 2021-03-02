#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'pathname'

options = ARGV.getopts('alr')
input_dir = ARGV[0]
