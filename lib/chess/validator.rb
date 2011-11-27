module Chess
  class Validator
    include Rules

    def self.legal?(board, origin, destination)
      self.new(board, origin, destination).check_legality
    end

    attr_reader :board
    attr_reader :origin
    attr_reader :destination
    attr_reader :piece

		def initialize(board, origin, destination)
      @board       = board.clone
      @origin      = board.notation.translate_position(origin)
      @destination = board.notation.translate_position(destination)
      @piece       = board.piece_at(origin)
		end

    def check_legality
      piece_exists_at_origin              and
      same_team_not_occupying_destination and
      valid_move_given_piece              and
      open_path_to_destination            and
      king_would_remain_safe
    end
  end
end
