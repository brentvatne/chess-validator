module Chess
  class Board
    # Gets the notation class
    attr_reader :notation

    def initialize(initial_state, notation = Notations::AlgebraicNotation)
      @notation = notation
      create_new_board
      load_state(initial_state)
    end

    def create_new_board
      @board = Array.new(8).map { |col| col = Array.new(8).fill(:empty) }
    end

    def load_state(board_config)
      board_config.each { |piece| add_piece piece[:piece], piece[:coordinates] }
    end

    def rows
      @board.transpose
    end

    def columns
      @board
    end

    def add_piece(piece, coords)
      @board[coords.row][coords.column] = piece
    end

    def at(row, column=:blank)
      if (in_notation = row).kind_of? String
        coords = translate_to_coordinates(in_notation)
        row    = coords.row
        column = coords.column
      elsif (coords = row).kind_of? Coordinates
        row    = coords.row
        column = coords.column
      end

      @board[row][column]
    end

    def translate_to_coordinates(alg_position)
      @notation.translate_position(alg_position)
    end
  end
end
