module Chess
  module Parsers
    BoardParser = Object.new

    class << BoardParser
      def parse(board, notation = AlgebraicNotation)
        configuration = BoardConfiguration.new

        each_cell(board) do |cell, row_number, col_number|
          if has_piece?(cell)
            piece  = notation.translate_piece(cell)
            coords = Coordinates.new(row_number, col_number)
            configuration.add_piece(piece, coords)
          end
        end

        configuration
      end

      def has_piece?(cell)
        cell != "--"
      end

      def each_cell(board)
        board.split("\n").each_with_index do |row, n_row|
          row.split.each_with_index do |cell, n_col|
            yield(cell, 7 - n_row, n_col)
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
