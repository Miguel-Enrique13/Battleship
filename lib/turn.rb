require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'
require 'pry'

class Turn

  attr_reader :player, :computer_player

  def initialize(player, computer_player)
    @player = player
    @computer_player = computer_player
    @human_shots_fired = []
    @computer_shots_fired = []
  end

  def display_board
    print "=============COMPUTER BOARD=============\n"
    @computer_player.board.render
    print "==============PLAYER BOARD==============\n"
    @player.board.render(true)
  end

  def human_shoot
    print "Enter coordinate for your shot:\n> "
    shoot_coordinate = gets.chomp.upcase
    while !@computer_player.board.valid_coordinate?(shoot_coordinate) || @human_shots_fired.any? {|coordinate| coordinate == shoot_coordinate}
      print "Please enter a valid coordinate:\n> "
      shoot_coordinate = gets.chomp.upcase
    end
    @human_shots_fired << shoot_coordinate
    @computer_player.board.cells[shoot_coordinate].fire_upon
  end

  def computer_shoot
    shoot_coordinate = @player.board.cells.keys.sample
    while !@player.board.valid_coordinate?(shoot_coordinate) || @computer_shots_fired.any? {|coordinate| coordinate == shoot_coordinate}
      print "Please enter a valid coordinate:\n> "
      shoot_coordinate = @player.board.cells.keys.sample
    end
    @computer_shots_fired << shoot_coordinate
    @player.board.cells[shoot_coordinate].fire_upon
  end

  def results
    player_results
    computer_results
  end

  def player_results
    if @computer_player.board.cells[@human_shots_fired.last].render == "M"
      print "Your shot on #{@human_shots_fired.last} was a miss.\n"
    elsif @computer_player.board.cells[@human_shots_fired.last].render == "H"
      print "Your shot on #{@human_shots_fired.last} was a hit.\n"
    else
      print "Your shot on #{@human_shots_fired.last} has sunk a ship.\n"
    end
  end

  def computer_results
    if @player.board.cells[@computer_shots_fired.last].render == "M"
      print "My shot on #{@computer_shots_fired.last} was a miss.\n"
    elsif @player.board.cells[@computer_shots_fired.last].render == "H"
      print "My shot on #{@computer_shots_fired.last} was a hit.\n"
    else
      print "My shot on #{@computer_shots_fired.last} has sunk a ship.\n"
    end
  end






end
