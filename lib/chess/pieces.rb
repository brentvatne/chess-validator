module Chess
  module Pieces
    # Internal: Base class for all chess board pieces.
    class Piece
			# Okay, maybe I tried to get a bit clever here and might not have
			# entirely suceeded, but I left it in because it works, is quite
			# readable, and is pretty DRY.
      class << self
        # Internal: Gets moves for the class. This is not always the source of
        # truth for moves for a piece - refer to the moves instance method
        # instead for a definitive list.
        attr_reader :moves

        # Internal: Populates the moves class variable
        def define_moves(&block)
          @moves = []
          class_eval(&block)
        end

        def straight_in_any_direction(how_many)
          Array(how_many[:cells]).each do |n|
           @moves.push Move.new( n,  0), Move.new(-n,  0),
                       Move.new( 0,  n), Move.new( 0, -n)
          end
        end

        def diagonally_in_any_direction(how_many)
          Array(how_many[:cells]).each do |n|
           @moves.push Move.new( n,  n), Move.new(-n, -n),
                       Move.new(-n,  n), Move.new( n, -n)
          end
        end

        def l_shaped_in_any_direction
          @moves.push Move.new( 2,  1), Move.new( 2, -1),
                      Move.new(-2,  1), Move.new(-2, -1),
                      Move.new( 1,  2), Move.new( 1, -2),
                      Move.new(-1,  2), Move.new(-1, -2)
        end
      end

      # Gets a the color symbol, :black or :white
      attr_reader :color

      def initialize(color = :white)
        @color = color
      end

      def can_make_move?(move, *args)
        self.class.moves.include?(move)
      end
    end

    class Bishop < Piece
      define_moves do
        diagonally_in_any_direction :cells => 1..7
      end
    end

    class Rook < Piece
      define_moves do
        straight_in_any_direction :cells => 1..7
      end
    end

    class Queen < Piece
      define_moves do
        straight_in_any_direction   :cells => 1..7
        diagonally_in_any_direction :cells => 1..7
      end
    end

    class King < Piece
      define_moves do
        straight_in_any_direction   :cells => 1
        diagonally_in_any_direction :cells => 1
      end
    end

    class Knight < Piece
      define_moves do
        l_shaped_in_any_direction
      end
    end

    # Public: Knows whether a Pawn can perform a given move.
    # The Pawn is a special case; its moves vary depending on various factors,
    # unlike other pieces which, for every case currently covered, always have 
    # the same moves.
    class Pawn < Piece
      # Public: Determines whether the Pawn can make the given move.
      #
      # move                  - A Move instance; the delta of the original
      #                         position and the destination.
      # current_position      - A Coordinates instance that indicates the pawns
      #                         current position on the board.
      # destination_has_enemy - A truthy or falsey value indicating whether or
      #                         not the destination cell has an enemy in it.
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
        available = [Move.new(0, 1 * direction)]

        if first_move?(current_position)
          available << Move.new(0, 2 * direction)
        end

        if destination_has_enemy
          available << Move.new(1, 1 * direction) << Move.new(-1, 1 * direction)
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
  end
end
