module Chess
  module Parsers
    BoardParser = Object.new

    class << BoardParser
      def parse(board, notation = AlgebreaicNotation)
        configuration = BoardConfiguration.new

        each_cell(board) do |cell, row_number, col_number|
          if has_piece?(cell)
            piece  = notation.translate_piece(cell)
            coords = Coordinates.new(row_number, col_number)
            configuration.add(piece, coords)
          end
        end
      end

      def has_piece?(cell)
        cell != "--"
      end

      def each_cell(board)
        board.split("\n").each_with_index do |n_row, row|
          row.split(" ").each_with_index do |n_col, cell|
            yield(cell, n_row, n_col)
          end
        end
      end
    end


    MoveParser = Object.new

    class << MoveParser
      def parse(moves, notation = AlgebraicNotation)

      end
    end
  end
end

#goal: get to point where I can start testing Validator
#as follows:
#
# describe "destination_within_board_boundaries" do
#   it "should return false if not within boundaries" do
#     Validator.legal?(board, "a10", "a60").should_not be_true
#
#   end
#
#   it "should return true if within boundaries" do
#
#   end
# end
