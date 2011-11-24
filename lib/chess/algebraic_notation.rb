module Chess
  AlgebraicNotation = Object.new

  class << AlgebraicNotation

    # Translates from algebreaic notation to an array
    #
    # position - A String position in algebraic notation
    #
    # Example
    #
    #   AlgebraicNotation.translate_position("a1")
    #   # => { :left => 0, :down => 7 }
    #
    # Returns an array containing the position information
    # in the form [x, y]
    def translate_position(position)

    end


    # Translates from algebreaic notation to a hash
    #
    # piece - A String piece in algebraic notation
    #
    # Example
    #
    #   AlgebraicNotation.translate_piece("bR")
    #   # => { :color => "black", :piece => "rook" }
    #
    # Returns a hash containing piece information
    def translate_piece(piece)
      colors = { :b => :black,  :w => :white }
      pieces = { :P => :pawn,   :N => :knight,
                 :B => :bishop, :R => :rook,
                 :Q => :queen,  :K => :king  }

      color_code, piece_code = piece.split("").map(&:to_sym)

      { :color => colors[color_code],
        :piece => pieces[piece_code] }
    end

  end
end
