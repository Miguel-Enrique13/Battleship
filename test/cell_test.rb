require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'pry'

class CellTest<Minitest::Test

 def setup
   cell = Cell.new("B4")
 end

 def test_cell_exists
   cell = Cell.new("B4")

   assert_instance_of Cell, cell
 end

 def test_cell_has_coordinate
  cell = Cell.new("B4")

  assert_equal "B4", cell.coordinate
 end

 def test_cell_has_ship
   cell = Cell.new("B4")

   assert_nil cell.ship
 end

 def test_cell_is_empty
   cell = Cell.new("B4")

   assert_equal true, cell.empty?
 end

 def test_ship_can_be_placed
   cruiser = Ship.new("cruiser", 3)
   cell = Cell.new("B4")
   cell.place_ship(cruiser)

   assert_equal cruiser, cell.ship
   assert_equal false, cell.empty?
 end

 def test_if_fire_upon_is_false
   cell = Cell.new("B4")
   cruiser = Ship.new("cruiser", 3)
   cell.place_ship(cruiser)

   assert_equal false, cell.fired_upon?
 end

 def test_if_fire_upon_changes
   cell = Cell.new("B4")
   cruiser = Ship.new("cruiser", 3)
   cell.place_ship(cruiser)

   cell.fire_upon

   assert_equal true, cell.fired_upon?
   assert_equal 2, cell.ship.health
 end

 def test_if_render_works
   cell_1 = Cell.new("B4")
   cell_2 = Cell.new("C3")
   cruiser = Ship.new("Cruiser", 3)

   assert_equal ".", cell_1.render

   cell_1.fire_upon
   assert_equal "M", cell_1.render

   cell_2.place_ship(cruiser)
   assert_equal ".", cell_2.render
   assert_equal "S", cell_2.render(true)
   
   cell_2.fire_upon
   assert_equal "H", cell_2.render
   assert_equal false, cruiser.sunk?

   cruiser.hit
   cruiser.hit
   assert_equal true, cruiser.sunk?
   assert_equal "X", cell_2.render

 end


end
