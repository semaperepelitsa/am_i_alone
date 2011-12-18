#!/usr/bin/env ruby
$development = false
$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../lib/game_states', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../lib/game_objects', __FILE__))
require "game"

Game.new(800, 600, false).show
