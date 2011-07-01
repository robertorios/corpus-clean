#!/usr/bin/env ruby

input = ARGV[0]
output = ARGV[1]

File.open(input) do |input_file|
  File.open(output, 'w+') do |output_file|
    output_file.puts input_file.read.gsub(/\d+\s/ , "\n").gsub(/\n\s*\n/ , "\n")
  end
end
