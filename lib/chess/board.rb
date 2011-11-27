module Chess
  class Board
    # Gets the notation class
    attr_reader :notation

    # Public: Initializes the Board instance
    # initial_state - A hash with the following parameters
    #                 :piece => A Chess::Pieces::Piece subclass instance
    #                 :coordinates => A Coordinates instance
    # notation      - A singleton class that implements the Notations
    #                 interface. Optional, defaults to AlgebraicNotation
    def initialize(initial_state, notation = Notations::AlgebraicNotation)
      @notation = notation
      create_new_board
      load_state(initial_state)
    end

    # Internal: Initializes the 2-dimensional 8x8 array to be used for the board
    def create_new_board
      @board = Array.new(8).map { |col| col = Array.new(8).fill(:empty) }
    end

    # Internal: Configures the board to a given state (pieces in play and
    # locations of the pieces).
    def load_state(state)
      state.each { |item| put_piece item[:piece], item[:coordinates] }
    end

    # Internal: Gets the board's rows
    # Returns the board Array sorted by rows
    def rows; @board.transpose; end

    # Internal: Gets the board's columns
    # Returns the board Array sorted by columns
    def columns; @board; end

    # Public: Places the given piece at the given location, regardless of the
    # current contents of the cell.
    def put_piece(piece, position)
      @board[position.column][position.row] = piece
    end

    # Public: Moves a given piece to another place on the board, ignoring
    # any validation of rules.
    #
    # params - :from - A Coordinates instance
    #          :to   - A Coordinates instance
    #
    # Returns the board instance
    def move_piece!(params)
      old_home, new_home = params.values
      put_piece piece_at(old_home), new_home
      clear_cell(old_home)
    end

    # Public: Clears any cells contents
    def clear_cell(position)
      @board[position.column][position.row] = :empty
    end

    # Public: Fetch a piece at a given location
    #
    # column - Can be a Coordinates instance, a String using the board's
    #          notation, or an Integer representing a column. In the first two
    #          cases, the column variable will represent both the row and column.
    # row    - Optional, an Integer
    #
    # Returns a Chess::Pieces::Piece subclass instance, or :empty
    def piece_at(column, row = :blank)
      if row == :blank
        position = column
        position = notation.translate_position(position) if position.is_a? String
        row    = position.row
        column = position.column
      end

      @board[column][row]
    end

    # Public: Determines if the board is empty at a given position
    #
    # position - A Coordinates instance
    #
    # Returns true if empty at given position, false if not empty
    def empty_at?(position)
      piece_at(position) == :empty
    end

    # Public: Iterates over each cell on the board
    #
    # Yields the cell - either an instance of Chess::Pieces::Piece or :empty
    def each_cell
      columns.each_with_index do |column, column_number|
        column.each_with_index do |cell, row_number|
          yield(cell, column_number, row_number)
        end
      end
    end

    # Public: Finds the location of a King, given its color
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

    # Public: Selects every piece on the board
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
end
