module Chess
  module Parsers

    # Public: Parses a chess board into a format that can be used by Board.
    BoardParser = Object.new

    class << BoardParser
      # Public: Parses a board data string into Pieces and Coordinates
      #
      # board    - A String, usually will be read out of a file. Open it up
      #            first with File.open("board_file.txt").read and pass it in.
      # notation - Optional: A Class that can translate the notation system
      #            used for the given board. Imeplements the same
      #            interface as AlgebraicNotation.
      #
      # Returns an array of Hashes with keys :piece and :coordinates,
      # containing a Piece instance and Coordinates instance respectively.
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

      # Internal: Checks for an empty cells
      #
      # Returns true if it has a piece, false if it's empty
      def has_piece?(cell)
        cell != "--"
      end

      # Internal: Iterates over each cell in the board.
      #
      # Yields the cell String, column number, and row number.
      def each_cell(board)
        board.split("\n").each_with_index do |row, row_number|
          row.split.each_with_index do |cell, column_number|
            yield(cell, column_number, 7 - row_number)
          end
        end
      end
    end

    # Public: Parses a list of moves
    MoveParser = Object.new

    class << MoveParser

      # Public: Parses a moves data string
      #
      # move     - A String, usually will be read out of a file. Open it up
      #            first with File.open("moves_file.txt").read and pass it in.
      # notation - Optional: A Class that can translate the notation system
      #            used for the given board. Imeplements the same
      #            interface as AlgebraicNotation.
      #
      # Returns a Hash with the keys :origin and :destination, whose values
      # are both Strings in # algebraic notation (default) representing a
      # position on the board.
      def parse(moves, notation = Notations::AlgebraicNotation)
        reduce_moves(moves) do |parsed, origin, destination|
          parsed << { :origin => origin, :destination => destination }
        end
      end

      # Internal: Keep parse readable by abstracting out the messy inject
      #
      # Yields the total Array being accumulated, and the origin and destination
      # Strings for the given row.
      def reduce_moves(moves)
        moves.split("\n").inject([]) do |total, pair|
          yield(total, *pair.split)
        end
      end
    end
  end
end
