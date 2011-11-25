module Chess
  module Rules

    def piece_exists_at_origin(board = @board, origin = @origin)
      board.at(origin) != :empty
    end

    def same_team_not_occupying_destination(board = @board, origin = @origin, destination = @destination)
      return true if board.at(destination) == :empty
      board.at(origin).color != board.at(destination).color
    end
  end
end
