module Chess
  def self.legal_move?(board, origin, destination)
    Validator.legal?(board, origin, destination)
  end

  Validator = Object.new

  # this uses instance variables, should change away from singleton
  class << Validator
    include Rules

    def legal?(board, origin, destination, notation = Notations::AlgebraicNotation)
      bootstrap!(board, origin, destination, notation) and check_legality
    end

    def check_legality
      piece_exists_at_origin and
      same_team_not_occupying_destination and
      valid_move_given_piece #and
      #no_other_piece_in_path
    end

    def bootstrap!(board, origin, destination, notation)
      @board = board
      begin
        @origin      = notation.translate_position(origin)
        @destination = notation.translate_position(destination)
      rescue ArgumentError
        return false
      end
      @piece = @board.at(origin)
    end
  end
end
