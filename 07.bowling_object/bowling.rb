require 'test/unit'
require './shot'
require './flame'
require './game'

if __FILE__ == $PROGRAM_NAME
  game = Game.new(ARGV[0])
  puts game.score
end
