module Chess
  def self.legal_move?(board, origin, destination)
    Validator.legal?(board, origin, destination)
  end

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
  end

  Validator = Object.new

  class << Validator
    include Rules

    def legal?(board, origin, destination, notation = AlgebraicNotation)
      @board       = board
      @origin      = origin
      @destination = destination
      @notation    = notation
      check_legality
    end

    def check_legality
      piece_exists_at_origin
    end
  end
end
