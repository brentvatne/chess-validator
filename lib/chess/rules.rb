module Chess
  # Keep of knowledge for the meaning of each movement rule. An important
  # exclusion is the moves available to each piece - this is something a piece
  # should know for itself.
  # Operates on reader methods for instance variables defined in the including
  # class. See Chess::Validator.
  module Rules
    # Internal: Determines if the board has a piece, or if it has been asked to
    # move nothing
    #
    # Returns true if a piece is there or false if not
    def piece_exists_at_origin
      occupied?(origin)
    end

    # Internal: Determines if the destination cell is occupied by the same team
    #
    # Returns true if the destination is empty or not the same team, false if
    # the cell is occupied by the same team.
    def same_team_not_occupying_destination
      not occupied?(destination) or piece.color != board.piece_at(destination).color
    end

    # Internal: Asks the piece that is supposed to move if it is capable of
    # performing the move.
    #
    # Returns true if it can make the move, false otherwise.
    def valid_move_given_piece
      piece.can_make_move?(Move.new(delta_column, delta_row), origin, destination_has_enemy?)
    end

    # Internal: Looks at the piece's path to the destination to determine if
    # it is open.
    #
    # Returns true if the path is available, or false if not.
    def open_path_to_destination
      if path = path_to_destination
        path.each { |cell| return false if occupied?(cell) }
      end
    end

    # Internal: Determines if the King of the same color as the moving piece
    # will be put in a check position from the proposed move.
    #
    # Note: The method that performs this will alter the state of this
    # Validator instance, so the call is wrapped in another method that saves
    # and then restores the state of all instance variables after it's done.
    #
    # Returns true if the King will be safe, false if the King will be put
    # in danger.
    def king_would_remain_safe
      restore_state_after do
        not exposes_king_to_check?
      end
    end

    # ********************************************************************
    # The following helper methods support the above higher level rules.
    # ********************************************************************

    # Internal: Checks every enemy piece to see if they would be able to attack
    # the King if the move were to take place.
    #
    # Returns true if King is exposed to check, false otherwise
    def exposes_king_to_check?
      board.move_piece! :from => origin, :to => destination

      @destination = board.king_position(piece.color)
      enemy_color = if piece.color == :black then :white else :black end

      board.positions_of_pieces(enemy_color) do |coords|
        @origin = coords; @piece = board.piece_at(coords)
        return true if valid_move_given_piece and open_path_to_destination
      end

      false
    end

    # Internal: Saves the state of the board, executes the given block and
    # then restores the original sate
    #
    # Returns the blocks return value
    def restore_state_after
      origin_backup      = origin
      destination_backup = destination
      piece_backup       = piece
      dest_piece_backup  = board.piece_at(destination)

      block_return_value = yield

      @origin      = origin_backup
      @destination = destination_backup
      board.put_piece piece_backup, origin
      board.put_piece dest_piece_backup, destination

      block_return_value
    end

    # Internal: Determines if the destination cell is occupied by an enemy.
    #
    # Returns true if it is occupied by an enemy, false if not.
    def destination_has_enemy?
      if occupied?(destination)
        board.piece_at(destination).color != board.piece_at(origin).color
      end
    end

    # Internal: Determines if the board is occupied at the given position.
    #
    # Returns true if the cell contains a piece, false if it is empty.
    def occupied?(position)
      not board.empty_at?(position)
    end

    # Internal: The difference between the destination row and the origin row
    #
    # Returns an Integer
    def delta_row
      (destination.row - origin.row)
    end

    # Internal: The difference between the destination col and the origin col
    #
    # Returns an Integer
    def delta_column
      (destination.column - origin.column)
    end

    # Internal: Selects between all valid movements which must occur given the
    # move. For example, we know that if delta row == delta column, this will
    # mean that we have to move diagonally.
    def path_to_destination
      direct_path || diagonal_path || horizontal_path || vertical_path
    end

    # Internal: Determines if there exists a direct path from the origin to
    # the destination; ie: the movement cannot be blocked by another piece.
    #
    # Returns an empty Array, which means there are no cells between the
    # origin and the destination that can block the movement.
    def direct_path
      if (delta_row.abs <= 1 and delta_column.abs <= 1) or piece.kind_of? Chess::Pieces::Knight
        []
      end
    end

    # Internal: Determines if there exists a horizontal path from the origin to
    # the destination. This would be the case with Rooks and sometimes Queens.
    #
    # Returns an Array of Coordinates representing cells in the path.
    def horizontal_path
      if delta_row == 0
        columns_between_origin_destination.inject([]) do |paths, n|
          paths << Coordinates.new(n, origin.row)
        end
      end
    end

    # Internal: Determines if there exists a vertical path from the origin to
    # the destiantion. This would be the case with Rooks and sometimes Queens.
    #
    # Returns an Array of Coordinates representing cells in the path.
    def vertical_path
      if delta_column == 0
        rows_between_origin_destination.inject([]) do |paths, n|
          paths << Coordinates.new(origin.column, n)
        end
      end
    end

    # Internal: Determines if there exists a diagonal path from the origin to
    # the destination. This would be the case with Bishops and maybe Queens.
    #
    # Returns an Array of Coordinates representing cells in the path.
    def diagonal_path
      if delta_row.abs == delta_column.abs
        rows_between_origin_destination.inject([]) do |paths, n|
          paths << Coordinates.new(n, n)
        end
      end
    end

    # Internal: Gets the the row numbers that exist between the origin and
    # destination, not including the origin and destination rows themselves.
    #
    # Returns an Array of Integers
    def rows_between_origin_destination
      first_row, last_row = [origin.row, destination.row].sort
      (first_row..last_row).to_a.tap(&:pop).tap(&:shift)
    end

    # Internal: Gets the the column numbers that exist between the origin
    # and destination, not including the origin and destination columns
    # themselves.
    #
    # Returns an Array of Integers
    def columns_between_origin_destination
      first_col, last_col = [origin.column, destination.column].sort
      (first_col..last_col).to_a.tap(&:pop).tap(&:shift)
    end
  end
end
