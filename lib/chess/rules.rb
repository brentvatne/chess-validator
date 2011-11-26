module Chess
  module Rules
    def piece_exists_at_origin
      board.at(origin) != :empty
    end

    def same_team_not_occupying_destination
      return true if not occupied?(destination)
      board.at(origin).color != board.at(destination).color
    end

    def valid_move_given_piece
      move = Move.new(destination.column - origin.column, destination.row - origin.row)
      board.at(origin).can_make_move?(move, origin, destination_has_enemy?)
    end

    def open_path_to_destination
      path_to_destination.each { |cell| return false if occupied?(cell) }
    end

    # Internal: Moves a given piece to another place on the board, ignoring
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
      board.move_piece! :from => origin, :to => destination

      destination = board.find_king(color)
      enemy_color = if color == :black then :white else :black end

      board.each_piece(enemy_color) do |coords|
        origin = coords
        return true if valid_move_given_piece and open_path_to_destination
      end
    end

    # Internal: Saves the validator state and restores it once the block is
    # executed.
    #
    # Returns the passed in block's return value.
    def king_would_remain_safe
      true
      # temporarily_change_state do
      #   exposes_king_to_check?(piece.color)
      # end
    end

    # Helper Methods
    private

    def destination_has_enemy?
      board.at(destination) != :empty and board.at(destination).color != board.at(origin).color
    end

    def occupied?(coords)
      board.at(coords) != :empty
    end

    def path_to_destination
      delta_row = destination.row - origin.row
      delta_col = destination.column - origin.column
      return [] if (delta_row <= 1 and delta_col <= 1)

      if delta_row.abs == delta_col.abs
        (origin.row+1..destination.row-1).inject([]) do |paths, n|
          paths << Coordinates.new(n, n)
        end
      elsif delta_col == 0
        (origin.row+1..destination.row-1).inject([]) do |paths, n|
          paths << Coordinates.new(origin.row, n)
        end
      elsif delta_row == 0
        (origin.column+1..destination.column-1).inject([]) do |paths, n|
          paths << Coordinates.new(n, origin.column)
        end
      end
    end
  end
end
