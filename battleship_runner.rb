require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/turn'
require './lib/game'

board1 = Board.new
board2 = Board.new

cruiser1 = Ship.new("Cruiser", 3)
submarine1 = Ship.new("Submarine", 2)
cruiser2 = Ship.new("Cruiser", 3)
submarine2 = Ship.new("Submarine", 2)

ships1 = [cruiser1, submarine1]
ships2 = [cruiser2, submarine2]

print "Input Player name: "
player = gets.chomp

comp_player = Player.new("Computer", board1, ships1)
user_player = Player.new(player, board2, ships2)

game = Game.new(user_player, comp_player)
game.start
