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

    # Public: Keeper of knowledge for whether a Pawn can perform a certain move
    # given environmental conditions of the board
    class Pawn < Piece
      # Public: Decides whether the pawn can make the given move or not.
      # The Pawn is the most complicated piece because it has two special cases:
      # it can move diagonally if it is attacking, and it can move forward two 
      # cells if it has not yet moved.
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
      def can_make_move?(move, current_position, destination_has_enemy = false)
        moves(current_position, destination_has_enemy).include?(move)
      end

      # Internal: Determines what moves the pawn can make given its current
      # position and whether or not the destination cell is home to an enemy.
      #
      # Returns an Array of Move instances
      def moves(current_position, destination_has_enemy)
        available = []
        available << Move.new(0, 1 * direction)

        if first_move?(current_position)
          available << Move.new(0, 2 * direction)
        end

        if destination_has_enemy
          available << Move.new(1, 1 * direction)
          available << Move.new(-1, 1 * direction)
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
      def can_make_move?(move, *args)
        moves.include?(move)
      end

      def moves
        #[1,2,-1,-2].each_permutation_of(2)
        [ Move.new(-2, 1),  Move.new(-1, 2),
          Move.new(1, 2),   Move.new(2, 1),
          Move.new(2, -1),  Move.new(1, -2),
          Move.new(-1, -2), Move.new(-2, -1) ]
      end
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
