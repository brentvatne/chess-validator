module Chess
  class Board
    # Gets the notation class
    attr_reader :notation

    def initialize(initial_state, notation = Notations::AlgebraicNotation)
      @notation = notation
      create_new_board
      load_state(initial_state)
    end

    def rows; @board; end

    def columns; @board.transpose; end


    def create_new_board
      @board = Array.new(8).map { |col| col = Array.new(8).fill(:empty) }
    end

    def load_state(board_config)
      board_config.each { |piece| add_piece piece[:piece], piece[:coordinates] }
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
      empty_cell! from
    end

    def empty_cell!(cell)
      @board[cell.row][cell.column] = :empty
    end

    # Internal: Finds the location of a King, given its color
    #
    # color - A symbol, either :black or :white, representing the color of the
    #         King to find.
    #
    # Returns a Coordinates instance with the location of the King.
    def king_position(color)
      columns.each_with_index do |column, column_number|
        column.each_with_index do |cell, row_number|
          if cell.kind_of? Pieces::King and cell.color == color
            return Coordinates.new(column_number, row_number)
          end
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

      columns.each_with_index do |column, column_number|
        column.each_with_index do |cell, row_number|
          if cell != :empty and (cell.color == color or color == :all)
            yield Coordinates.new(column_number, row_number)
          end
        end
      end

    end
  end
end
