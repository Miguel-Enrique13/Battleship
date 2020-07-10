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
    if !fired_upon?
      if empty? || (!empty? && !display_ship)
        "."
      else
        "S"
      end
    elsif empty?
      "M"
    elsif !empty? && !@ship.sunk?
      "H"
    elsif !empty? && @ship.sunk?
      "X"
    end
  end

end
