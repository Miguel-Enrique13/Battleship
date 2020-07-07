require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require 'pry'

class ShipTest<Minitest::Test
  def setup
    cruiser = Ship.new("Cruiser", 3)
  end

  def test_ship_exists
    cruiser = Ship.new("cruiser", 3)
    assert_instance_of Ship, cruiser
  end

  def test_ship_has_name
    cruiser = Ship.new("cruiser", 3)
    assert_equal "cruiser", cruiser.name
  end

  def test_ship_has_length
    cruiser = Ship.new("cruiser", 3)
    assert_equal 3, cruiser.length
  end

  def test_ship_has_health
    cruiser = Ship.new("cruiser", 3)
    assert_equal 3, cruiser.health
  end

  def test_ship_has_sunk
    cruiser = Ship.new("cruiser", 3)
    assert_equal false, cruiser.sunk?
  end

  def test_ship_has_been_hit
    cruiser = Ship.new("cruiser", 3)

    cruiser.hit
    assert_equal 2, cruiser.health

    cruiser.hit
    assert_equal 1, cruiser.health
  end
end
