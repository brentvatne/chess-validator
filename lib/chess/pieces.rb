module Chess
  module Pieces
    class Piece
      # Get a the color symbol, :black or :white
      attr_reader :color

      def initialize(color)
        @color = color
      end
    end

    class Pawn < Piece
    end
    class Knight  < Piece
    end
    class Bishop  < Piece
    end
    class Rook  < Piece
    end
    class Queen  < Piece
    end
    class King  < Piece
    end
  end
end
