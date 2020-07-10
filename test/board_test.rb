require './lib/ship'
require './lib/cell'
require './lib/board'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class BoardTest<Minitest::Test
  def test_board_exist
    board = Board.new
    assert_instance_of Board, board
  end

  def test_it_generates_default_rows
    board = Board.new

    assert_equal ["A", "B", "C", "D"], board.row
  end

  def test_it_generates_default_columns
    board = Board.new

    assert_equal ["1", "2", "3", "4"], board.column
  end

  def test_it_generates_customized_rows
    board = Board.new(6, 6)

    assert_equal ["A", "B", "C", "D", "E", "F"], board.row
  end

  def test_it_generates_customized_columns
    board = Board.new(6, 6)

    assert_equal ["1", "2", "3", "4", "5", "6"], board.column
  end

  def test_it_generates_instance_of_cell
    board = Board.new

    assert_instance_of Cell, board.cells.values[0]
    assert_equal 16, board.cells.keys.length
    assert_equal 16, board.cells.values.length
  end

  def test_valid_coordinate?
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_valid_placement?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_ship_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal true, cell_2.ship == cell_3.ship
  end

  def test_ship_overlapping
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_render_works
    board = Board.new(6, 6)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["C1", "D1"])


    board.render
    board.render(true)

    board.cells["A1"].fire_upon
    board.cells["B4"].fire_upon
    board.cells["C1"].fire_upon
    board.cells["D1"].fire_upon

    board.render
    board.render(true)


  end





end
