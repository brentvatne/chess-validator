module Chess
  module BoardAccessorMethods
    def rows; @board; end

    def columns; @board.transpose; end

    # piece_at?
    def at(row, column = :blank)
      if column == :blank
        position = row
        position = notation.translate_position(position) if position.is_a? String
        row    = position.row
        column = position.column
      end

      @board[row][column]
    end

    def each_cell
      columns.each_with_index do |column, column_number|
        column.each_with_index do |cell, row_number|
          yield(cell, column_number, row_number)
        end
      end
    end

    # Internal: Finds the location of a King, given its color
    #
    # color - A symbol, either :black or :white, representing the color of the
    #         King to find.
    #
    # Returns a Coordinates instance with the location of the King.
    def king_position(color)
      each_cell do |cell, column_number, row_number|
        if cell.is_a? Pieces::King and cell.color == color
          return Coordinates.new(column_number, row_number)
        end
      end
    end

    # Internal: Selects every piece on the board
    #
    # color - Optional, filters the yielded Pieces to those of the given color.
    #         Can be either :black or :white. Default is :all
    #
    # Yields an instance of a Chess::Pieces::Piece sublcass
    def positions_of_pieces(color = :all)
      each_cell do |cell, column_number, row_number|
        if cell != :empty and (cell.color == color or color == :all)
          yield Coordinates.new(column_number, row_number)
        end
      end
    end
  end

  class Board
    include BoardAccessorMethods
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

    # place_piece?
    def add_piece(piece, coords)
      @board[coords.row][coords.column] = piece
    end

    # Public: Moves a given piece to another place on the board, ignoring
    # any validation of rules.
    #
    # params - :from - A Coordinates instance
    #          :to   - A Coordinates instance
    #
    # Returns the board instance
    def move_piece!(params)
      from, to = params.values
      add_piece at(from), to
      @board[from.row][from.column] = :empty
      # empty_cell! from
    end
  end
end
