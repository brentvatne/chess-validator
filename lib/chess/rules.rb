module Chess
  module Rules
    def piece_exists_at_origin(board = @board, origin = @origin)
      board.at(origin) != :empty
    end

    def same_team_not_occupying_destination(board = @board, origin = @origin, destination = @destination)
      return true if board.at(destination) == :empty
      board.at(origin).color != board.at(destination).color
    end

    def valid_move_given_piece(board = @board, origin = @origin, destination = @destination, piece = @piece)
      move = Move.new(destination.column - origin.column, destination.row - origin.row)
      piece.can_make_move?(move, origin, has_enemy?)
    end

    def has_enemy?(board = @board, origin = @origin, destination = @destination)
      board.at(destination) != :empty and board.at(destination).color != board.at(origin).color
    end
  end
end
