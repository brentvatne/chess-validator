module Chess
  def self.legal_move?(board, origin, destination)
    Validator.legal?(board, origin, destination)
  end

  Validator = Object.new

  # this uses instance variables, should change away from singleton
  class << Validator
    include Rules

    def legal?(board, origin, destination)
      bootstrap!(board, origin, destination) and check_legality
    end

    def check_legality
      piece_exists_at_origin and
      same_team_not_occupying_destination and
      valid_move_given_piece and
      open_path_to_destination and
      does_not_expose_king_to_check
    end

    def bootstrap!(board, origin, destination)
      @board = board
      begin
        @origin      = board.notation.translate_position(origin)
        @destination = board.notation.translate_position(destination)
      rescue ArgumentError
        return false
      end
      @piece = @board.at(origin)
    end
  end
end
