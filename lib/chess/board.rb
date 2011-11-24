module Chess
  Coordinates = Struct.new(:column, :row)

  class Board
    def initialize(initial_state, notation = AlgebraicNotation)
      create_new_board
      load_state(initial_state)
    end

    def load_state
      initial_state.each { |piece| add_piece piece }
    end

    def add_piece

    end

    private

    def create_new_board
      @board = []
    end
  end
end
