#!/usr/bin/env ruby

require './app/play_toy_robot'

results = PlayToyRobot.call(ARGV[0])
puts ''

results.each { |result| puts "    #{result}" }

puts '     Nothing to do.' if results.empty?
puts ''

