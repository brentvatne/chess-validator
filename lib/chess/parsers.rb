module Chess
  module Parsers
    BoardParser = Object.new

    class << BoardParser
      def parse(board, notation = Notations::AlgebraicNotation)
        configuration = BoardConfiguration.new

        each_cell(board) do |cell, column, row|
          if has_piece?(cell)
            piece  = notation.translate_piece(cell)
            coords = Coordinates.new(column, row)
            configuration.add_piece(piece, coords)
          end
        end

        configuration
      end

      def has_piece?(cell)
        cell != "--"
      end

      def each_cell(board)
        board.split("\n").each_with_index do |row, row_number|
          row.split.each_with_index do |cell, column_number|
            yield(cell, column_number, 7 - row_number)
          end
        end
      end
    end

    MoveParser = Object.new

    class << MoveParser
      def parse(moves, notation = Notations::AlgebraicNotation)

      end
    end
  end
end
