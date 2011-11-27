module Chess
  module Parsers

    BoardParser = Object.new

    class << BoardParser
      def parse(board, notation = Notations::AlgebraicNotation)
        pieces = []

        each_cell(board) do |cell, column, row|
          if has_piece?(cell)
            piece  = notation.translate_piece(cell)
            coords = Coordinates.new(column, row)
            pieces << { :piece => piece, :coordinates => coords }
          end
        end

        pieces
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
        reduce_moves(moves) do |parsed, origin, destination|
          parsed << { :origin => origin, :destination => destination }
        end
      end

      def reduce_moves(moves)
        moves.split("\n").inject([]) do |total, pair|
          yield(total, *pair.split)
        end
      end
    end
  end
end
