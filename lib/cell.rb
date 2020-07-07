require './lib/ship'
require 'pry'

class Cell

  attr_reader :coordinate, :ship, :fire
  def initialize (coordinate)
    @coordinate = coordinate
    @ship
    @fire = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(name)
     @ship = name
  end

  def fired_upon?
    @fire == true
  end

  def fire_upon
    @fire = true
      if @ship != nil
        @ship.hit
      end
  end

  def render(display_ship = false)
    if empty? == true && @fire == false || empty? == false && @fire == false
      if display_ship == true
        "S"
      else
        "."
      end
    elsif empty? == true && @fire == true
      "M"
    elsif empty? == false && @fire == true && @ship.sunk? == false
      "H"
    elsif empty? == false && @fire == true && @ship.sunk? == true
      "X"
    end
  end

end
