#!/usr/bin/env ruby

require './app/play_toy_robot'

puts ''

PlayToyRobot.call(ARGV[0]).each do |result|
  puts "    #{result}"
end

puts ''

