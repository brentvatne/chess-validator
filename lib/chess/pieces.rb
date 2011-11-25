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
      def can_make_move?(move, position, enemy)
        moves(position, enemy).include?(move)
      end

      def moves(current_position, enemy = false)
        available = []
        available << Move.new(1 * direction, 0)
        available << Move.new(2 * direction, 0) if first_move?(current_position)
        if enemy
          available << Move.new(1 * direction, 1)
          available << Move.new(1 * direction, 1)
        end
        available
      end

      def attack_moves
        [ Move.new(1 * direction, 1), Move.new(1 * direction, 1) ]
      end

      def direction
        if color == :black then -1 else 1 end
      end

      def first_move?(position)
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
