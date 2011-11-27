module Chess
  module Rules
    def piece_exists_at_origin
      board.piece_at(origin) != :empty
    end

    def same_team_not_occupying_destination
      !occupied?(destination) or piece.color != board.piece_at(destination).color
    end

    def valid_move_given_piece
      piece.can_make_move?(Move.new(delta_column, delta_row), origin, destination_has_enemy?)
    end

    def open_path_to_destination
      if path = path_to_destination
        path.each { |cell| return false if occupied?(cell) }
      end
    end

    def path_to_destination
      direct_path || diagonal_path || horizontal_path || vertical_path
    end

    def king_would_remain_safe
      restore_state_after do
        ! exposes_king_to_check?(piece.color)
      end
    end

    def direct_path
      if (delta_row.abs <= 1 and delta_column.abs <= 1) or piece.kind_of? Chess::Pieces::Knight
        []
      end
    end

    def horizontal_path
      if delta_row == 0
        columns_in_between.inject([]) do |paths, n|
          paths << Coordinates.new(n, origin.row)
        end
      end
    end

    def vertical_path
      if delta_column == 0
        rows_in_between.inject([]) do |paths, n|
          paths << Coordinates.new(origin.column, n)
        end
      end
    end

    def diagonal_path
      if delta_row.abs == delta_column.abs
        rows_in_between.inject([]) do |paths, n|
          paths << Coordinates.new(n, n)
        end
      end
    end

    def rows_in_between
      first_row, last_row = [origin.row, destination.row].sort
      (first_row..last_row).to_a.tap(&:pop).tap(&:shift)
    end

    def columns_in_between
      first_col, last_col = [origin.column, destination.column].sort
      (first_col..last_col).to_a.tap(&:pop).tap(&:shift)
    end

    def exposes_king_to_check?(color)
      board.move_piece! :from => origin, :to => destination

      @destination = board.king_position(color)
      enemy_color = if color == :black then :white else :black end

      board.positions_of_pieces(enemy_color) do |coords|
        @origin = coords; @piece = board.piece_at(coords)
        return true if valid_move_given_piece and open_path_to_destination
      end

      false
    end

    private

    def delta_row
      (destination.row - origin.row)
    end

    def delta_column
      (destination.column - origin.column)
    end

    def destination_has_enemy?
      if occupied?(destination)
        board.piece_at(destination).color != board.piece_at(origin).color
      end
    end

    def occupied?(coords)
      board.piece_at(coords) != :empty
    end

    def restore_state_after
      origin_backup      = origin
      destination_backup = destination
      piece_backup       = piece
      dest_piece_backup  = board.piece_at(destination)

      return_value = yield

      @origin      = origin_backup
      @destination = destination_backup
      board.put_piece piece_backup, origin
      board.put_piece dest_piece_backup, destination

      return_value
    end
  end
end
