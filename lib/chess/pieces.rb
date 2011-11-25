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
      def moves
        if color == :black then direction = -1 else direction = 1 end

      end

      def first_turn
      end

      def original_position?(position)
        if color == :black
          position.row == 6
        else
          position.row == 1
        end
      end
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
