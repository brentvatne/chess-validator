module Chess
  Coordinates = Struct.new(:row, :column)

  class Board
    def initialize(initial_state, notation = AlgebraicNotation)
      @notation = notation
      create_new_board
      load_state(initial_state)
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

    def translate_to_coordinates(alg_position)
      @notation.translate_position(alg_position)
    end

    def at(row, column=:blank)
      if row.kind_of? String and column == :blank
        coords = translate_to_coordinates(row)
        row    = coords.row
        column = coords.column
      end

      @board[row][column]
    end

    def create_new_board
      @board = Array.new(8).map { |col| col = Array.new(8).fill(:empty) }
    end
  end
end
