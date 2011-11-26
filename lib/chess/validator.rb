module Chess
  def self.legal_move?(board, origin, destination)
    Validator.legal?(board, origin, destination)
  end

  class Validator
    include Rules

    def self.legal?(board, origin, destination)
      self.new.check_legality(board, origin, destination)
    end

    attr_reader :board
    attr_reader :origin
    attr_reader :destination
    attr_reader :piece

    def check_legality(board, origin, destination)
      bootstrap!(board, origin, destination) and
      piece_exists_at_origin                 and
      same_team_not_occupying_destination    and
      valid_move_given_piece                 and
      open_path_to_destination               and
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
