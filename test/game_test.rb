require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class GameTest<Minitest::Test

  def test_game_exist
    board1 = Board.new
    board2 = Board.new

    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    ships = [cruiser, submarine]

    comp_player = Player.new("Computer", board1, ships)
    user_player = Player.new("John", board2, ships)

    game = Game.new(user_player, comp_player)
    assert_instance_of Game, game
  end



end
