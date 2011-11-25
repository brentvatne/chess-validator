module Chess
  def self.legal_move?(board, origin, destination)
    Validator.legal?(board, origin, destination)
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
      cells_within_board_boundaries and
      piece_exists_at_origin and
      same_team_not_occupying_destination
    end
  end
end
