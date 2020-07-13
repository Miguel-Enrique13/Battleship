require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/turn'
require 'pry'

class Game

  attr_reader :player, :ship, :cell, :computer_player
  def initialize(player, computer_player)
    @player = player
    @computer_player = computer_player
  end

  def start
    start_display_message
    start_turns
    display_winner
  end

  def start_display_message
    print "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit. \n"
    print "> "
    if gets.chomp.upcase == "P"
      game_setup
    end
  end

  def game_setup
    computer_placement(@computer_player.ships)
    player_placement(@player.ships)
  end

  def computer_placement(ships)
    ships.each do |ship|
      ship_placement = [computer_horizontal_placement(ship.length), computer_vertical_placement(ship.length)]
      placement = ship_placement.sample
      until @computer_player.board.valid_placement?(ship, placement)
        ship_placement = [computer_horizontal_placement(ship.length), computer_vertical_placement(ship.length)]
        placement = ship_placement.sample
      end
      @computer_player.board.place(ship, placement)
    end
  end

  def computer_horizontal_placement(ship_size)
    horizontal_placement = []
    horizontal_coordinates = @computer_player.board.cells.keys.group_by { |coordinate| coordinate.split("")[0] }
    horizontal_coordinates.values.sample.each_cons(ship_size) { |a| horizontal_placement << a }
    return horizontal_placement.sample
  end

  def computer_vertical_placement(ship_size)
    vertical_placement = []
    vertical_coordinates = @computer_player.board.cells.keys.group_by { |coordinate| coordinate.split("")[1] }
    vertical_coordinates.values.sample.each_cons(ship_size) {|a| vertical_placement << a}
    return vertical_placement.sample
  end

  def player_placement(ships)
    player_message
    get_coordinates(ships)
  end

  def player_message
    print "I have laid out my ships on the grid. \nYou now need to lay out your two ships.\n"
    print "The Cruiser is three units long and the Submarine is two units long.\n"
    @player.board.render
  end

  def get_coordinates(ships)
    ships.each do |ship|
      print "\nEnter the squares for the #{ship.name} (#{ship.length} spaces)\n"
      print "> "

      ship_coordinates = gets.chomp.upcase.split(" ")

      until @player.board.valid_placement?(ship, ship_coordinates)
        print "\nThose are invalid coordinates. Please try Again\n"
        print "> "
        ship_coordinates = gets.chomp.upcase.split(" ")
      end
      @player.board.place(ship, ship_coordinates)
      @player.board.render(true)
    end
  end

  def start_turns
    turn = Turn.new(@player, @computer_player)
    until @player.player_lost? || @computer_player.player_lost?
      turn.display_board
      turn.human_shoot
      turn.computer_shoot
      turn.results
    end
  end

  def display_winner
    if @player.player_lost?
      print "I won!"
    else
      print "You won!"
    end
  end

end
