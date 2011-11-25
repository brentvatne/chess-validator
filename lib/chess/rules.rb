module Chess
  module Rules

    def cells_within_board_boundaries(origin = @origin, destination = @destination, notation = @notation)
      begin
        notation.translate_position(origin)
        notation.translate_position(destination)
      rescue ArgumentError
        return false
      end
    end

    def piece_exists_at_origin(board = @board, origin = @origin)
      board.at(origin) != :empty
    end

    def same_team_not_occupying_destination(board = @board, origin = @origin, destination = @destination)
      board.at(origin).color != board.at(destination).color
    end
  end
end
