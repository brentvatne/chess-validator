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

    def occupied?(cell, board = @board)
      board.at(cell) != :empty
    end

    def open_path_to_destination(board = @board, origin = @origin, destination = @destination)
      path_for(board, origin, destination).each { |cell| return false if occupied?(cell, board) }
    end

    def path_for(board, origin, destination)
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
