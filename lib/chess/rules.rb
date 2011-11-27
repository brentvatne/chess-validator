module Chess
  module Rules
    def piece_exists_at_origin
      board.at(origin) != :empty
    end

    def same_team_not_occupying_destination
      return true if not occupied?(destination)
      piece.color != board.at(destination).color
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

    # Public: Moves a given piece to another place on the board, ignoring
    # any validation of rules.
    #
    # params - :from - A Coordinates instance
    #          :to   - A Coordinates instance
    #
    # Returns the board instance
    # def move_piece!(params)
    #
    # Internal: Finds the location of a King, given its color
    #
    # color - A symbol, either :black or :white, representing the color of the
    #         King to find.
    #
    # Returns a Coordinates instance with the location of the King.
    #
    # Internal: Selects every piece on the board
    #
    # color - Optional, filters the yielded Pieces to those of the given color.
    #         Can be either :black or :white. Default is :all
    def exposes_king_to_check?(color)
      true
      # board.move_piece! :from => origin, :to => destination

      # destination = board.find_king(color)
      # enemy_color = if color == :black then :white else :black end

      # board.each_piece(enemy_color) do |coords|
      #   origin = coords
      #   return true if valid_move_given_piece and open_path_to_destination
      # end
    end

    # Internal: Saves the validator state and restores it once the block is
    # executed.
    #
    # Returns the passed in block's return value.
    def king_would_remain_safe
      restore_state_after do
        exposes_king_to_check?(piece.color)
      end
    end

    private

    def delta_row
      (destination.row - origin.row)
    end

    def delta_column
      (destination.column - origin.column)
    end

    def destination_has_enemy?
      board.at(destination) != :empty and board.at(destination).color != board.at(origin).color
    end

    def occupied?(coords)
      board.at(coords) != :empty
    end

    def restore_state_after
      board_backup       = board.clone
      origin_backup      = origin.clone
      destination_backup = destination.clone
      piece_backup       = piece.clone

      return_value = yield

      @board       = board_backup
      @origin      = origin_backup
      @destination = destination_backup
      @piece       = piece_backup
    end
  end
end
