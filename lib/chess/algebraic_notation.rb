module Chess
  # Translates from algebraic notation to data structures that interface
  # with the Board
  # Note: This class uses the Singleton pattern, as there is no need
  # for instances
  AlgebraicNotation = Object.new

  class << AlgebraicNotation

    # Translates from algebreaic notation to an array
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
    # 7                             8
    # 6                             7
    # 5                             6
    # 4  Internal Representation    5    Algebraic Notation
    # 3                             4
    # 2                             3
    # 1                             2
    # 0                             1
    #  0  1  2  3  4  5  6  7  8      a  b  c  d  e  f  g  h
    #
    # Returns a Hash containing the position information in the
    # form { :x => x, :y => y }
    def translate_position(position)

    end


    # Translates from algebreaic notation to a hash
    #
    # piece - A String piece in algebraic notation
    #
    # Example
    #
    #   AlgebraicNotation.translate_piece("bR")
    #   # => { :color => "black", :type => "rook" }
    #
    # Returns a hash containing piece information
    def translate_piece(piece)
      colors = { :b => :black,  :w => :white }
      pieces = { :P => :pawn,   :N => :knight,
                 :B => :bishop, :R => :rook,
                 :Q => :queen,  :K => :king  }

      color_code, piece_code = piece.split("").map(&:to_sym)

      { :color => colors[color_code],
        :type  => pieces[piece_code] }
    end
  end
end
