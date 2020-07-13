require './lib/ship'
require './lib/cell'
require './lib/board'

class Player
  attr_reader :board, :name, :ships
  def initialize(name, board, ships)
    @name = name
    @ships = ships
    @board = board
  end

  def player_lost?
    @ships.all? { |ship| ship.sunk? == true}
  end
end
