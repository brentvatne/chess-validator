module Chess
  module Pieces
    # Internal: Base class for all chess board pieces.
    class Piece
      # Gets a the color symbol, :black or :white
      attr_reader :color

      def initialize(color)
        @color = color
      end
    end

    class Pawn < Piece
      # Public: Decides whether the pawn can make the given move or not,
      # given environmental factors.
      #
      # move                  - A Move instance that is the delta of the
      #                         original position and the destination.
      # current_position      - A Coordinates instance that indicates the pawns
      #                         current position on the board. Used to determine
      #                         if the pawn has moved or not.
      # destination_has_enemy - A truthy or falsey value, whether or not the
      #                         destination cell has an enemy in it.
      #
      # Returns true if the Pawn can perform the provided move, false if not.
      def can_make_move?(move, current_position, destination_has_enemy)
        moves(current_position, destination_has_enemy).include?(move)
      end

      # Internal: Determines what moves the pawn can make given its current
      # position and whether or not the destination cell is home to an enemy.
      #
      # Arguments are the same as the equivalent arguments in can_make_move?
      #
      # Returns an Array of Move instances
      def moves(current_position, destination_has_enemy = false)
        available = []
        available << Move.new(1 * direction, 0)

        if first_move?(current_position)
          available << Move.new(2 * direction, 0)
        end

        if destination_has_enemy
          available << Move.new(1 * direction, 1)
          available << Move.new(1 * direction, -1)
        end

        available
      end

      # Internal: Based on color, determines if the pawn can move up or down
      #
      # Returns -1 if black, 1 if white
      def direction
        if color == :black then -1 else 1 end
      end

      # Internal: Based on color, determines if the pawn has moved from its
      # original position.
      #
      # Returns true if this is the first move, false if it has already moved.
      def first_move?(position)
        if color == :black then position.row == 6 else position.row == 1 end
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
