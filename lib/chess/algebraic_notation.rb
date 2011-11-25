module Chess
  # Translates from algebraic notation to data structures that interface
  # with the Board
  AlgebraicNotation = Object.new

  class << AlgebraicNotation
    # Translate back as well for printing the board
    # Use #invert on the hash
    Colors  = { :b => :black,  :w => :white }
    Pieces  = { :P => Pieces::Pawn,   :N => Pieces::Knight,
                :B => Pieces::Bishop, :R => Pieces::Rook,
                :Q => Pieces::Queen,  :K => Pieces::King }
    Columns = { :a => 0, :b => 1, :c => 2, :d => 3,
                :e => 4, :f => 5, :g => 6, :h => 7 }
    Rows    = {  1 => 0,  2 => 1,  3 => 2,  4 => 3,
                 5 => 4,  6 => 5,  7 => 6,  8 => 7 }

    # Translates from algebreaic notation to a struct that responds to :x and :y
    #
    # position - A String position in algebraic notation
    #
    # Example
    #
    #   AlgebraicNotation.translate_position("a1")
    #   # => { :x => 0, :y => 7 }
    #
    # The board is laid out as follows:
    #
    #        7                            8
    #        6                            7
    #        5                            6
    #  rows  4  Internal Representation   5   Algebraic Notation
    #        3                            4
    #        2                            3
    #        1                            2
    #        0                            1
    #          0  1  2  3  4  5  6  7       a  b  c  d  e  f  g  h
    #                  columns
    #
    # Returns a Hash containing the internal representation
    # Raises ArgumentError if the row or column are not recognized

    def translate_position(position)
      alg_col, alg_row = position.split("")

      raise ArgumentError,
				"Invalid row #{alg_row}" unless Rows.has_key?(alg_row.to_i)
      raise ArgumentError,
				"Invalid column #{alg_col}" unless Columns.has_key?(alg_col.to_sym)

      Coordinates.new(Rows[alg_row.to_i], Columns[alg_col.to_sym])
    end

    # Translates from algebreaic notation to a hash
    #
    # piece - A String piece in algebraic notation
    #
    # Example
    #
    #   AlgebraicNotation.translate_piece("bR")
    #   # => An instance of the Rook class, with color set to :black
    #
    # Raises an exception if the piece or color code is not recognized
    #
    # Returns an instance of the corresponding piece class
    # Raises an ArgumentError if the piece or color are not recognized
    def translate_piece(piece)
      color_code, piece_code = piece.split("").map(&:to_sym)

      raise ArgumentError,
				"Invalid piece #{piece_code}" unless Pieces.has_key?(piece_code)
      raise ArgumentError,
				"Invalid color #{color_code}" unless Colors.has_key?(color_code)

      Pieces[piece_code].new(Colors[color_code])
    end
  end
end
