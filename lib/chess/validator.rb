module Chess
  def self.legal_move?(board, origin, destination)
    Validator.legal?(board, origin, destination)
  end

  module Rules
    def piece_exists_at_origin(board = @board, origin = @origin)
      board.at(origin) != :empty
    end

  end

  Validator = Object.new

  class << Validator
    include Rules

    def legal?(*args)
      true
    end
  end
end
