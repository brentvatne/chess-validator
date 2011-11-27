module Chess
  # Operates on the board to determine whether a move is legal, given the
  # rules of chess.
  class Validator
    include Rules

    # Public: Checks if a move on the given board from origin to destination
    # is legal.
    #
    # board       - A Board instance
    # origin      - A Coordinates instance
    # destination - A Coordinates instance
    #
    # Returns true if legal, false if not.
    def self.legal?(board, origin, destination)
      self.new(board, origin, destination).check_legality
    end

    attr_reader :board
    attr_reader :origin
    attr_reader :destination
    attr_reader :piece

    # Internal: Initializes a Validator instance
    def initialize(board, origin, destination)
      @board       = board
      @origin      = board.notation.translate_position(origin)
      @destination = board.notation.translate_position(destination)
      @piece       = board.piece_at(origin)
    end

    # Internal: Tests each rules relevant to making a move in chess. Each is
    # tested independently of the others. For example, a move can be considered
    # valid by the piece even if there is a teammate in its path, but when
    # the open_path_to_destination check is run, that case will be covered.
    #
    # Returns true if legal, false if not legal.
    def check_legality
      piece_exists_at_origin              and
      same_team_not_occupying_destination and
      valid_move_given_piece              and
      open_path_to_destination            and
      king_would_remain_safe
    end
  end
end
