module Chess
  Coordinates = Struct.new(:row, :column)

  class NotOnBoard < ArgumentError; end

  class Board
    def initialize(initial_state, notation = AlgebraicNotation)
      @notation = notation
      create_new_board
      load_state(initial_state)
    end

    def load_state(board_config)
      board_config.each { |piece| add_piece piece[:piece], piece[:coordinates] }
    end

    def add_piece(piece, coords)
      @board[coords.row][coords.column] = piece
    end

    def translate_to_coordinates(alg_position)
      @notation.translate_position(alg_position)
    end

    def verify_validity_of!(row, column)
      is_on_board = (0 <= row && row <= 7) && (0 <= column && column <= 7)
      raise NotOnChessBoard "Row: #{row}, Column #{column}" unless is_on_board
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

    def rows
      @board.transpose
    end

    def columns
      @board
    end
  end
end
