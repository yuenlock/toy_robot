#!/usr/bin/env ruby

require './app/play_toy_robot'

PlayToyRobot.call(ARGV[0], game: Robots::Robot)
