require './lib/ship'
require './lib/cell'
require "pry"

class Board

 attr_reader :row, :column, :cells
 def initialize(row = 4, column = 4)
   @row = row
   @column = column
   @cells = generate_cells
 end

 def row_height
   @row = ("A".."Z").to_a[0..(@row - 1)]
 end

 def column_width
   @column = ("1".."26").to_a[0..(@column - 1)]
 end

 def generate_cells
   @cells = Hash.new
   height = row_height
   width = column_width
   height.each do |row|
     width.each do |column|
       @cells[row + column] = Cell.new(row + column)
     end
   end
   return @cells
 end

 def valid_coordinate?(key)
   @cells[key] != nil
 end

 def valid_placement?(ship, array)
   consecutive_placement?(ship, array) && !overlapping?(array)
 end

 def consecutive_placement?(ship, array)
  (vertical_placement?(ship, array) || horizontal_placement?(ship,array))
 end

 def vertical_placement?(ship, array)
  vertical_hash = @cells.keys.group_by { |coordinate| coordinate.split("")[1] % 1 }
  vertical_array = vertical_hash.values.flatten
  vertical_intial_value = vertical_array.index(array[0])
  vertical = vertical_array[vertical_intial_value, ship.length]

  vertical == array
 end

 def horizontal_placement?(ship, array)
  horizontal_initial_value = @cells.keys.index(array[0])
  horizontal = @cells.keys[horizontal_initial_value, ship.length]

  horizontal == array

 end

 def place (ship, array)
   array.each do |coordinate|
     @cells[coordinate].place_ship(ship)
   end
 end

 def overlapping?(array)
   array.any? { |coordinate| @cells[coordinate].ship.is_a?(Ship) }
 end

 def render(display_ship = false)
   header
   board_print(display_ship)
 end

 def board_print(display_ship)
   @row.each do |row|
     print "#{row} "
     @column.each do |column|
       print "#{@cells[row + column].render(display_ship)} "
     end
     print "\n"
   end

 end

 def header
   print "  "
   @column.each do |column|
     print "#{column} "
   end
   print "\n"
 end


end
