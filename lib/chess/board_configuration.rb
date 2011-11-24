module Chess
  # Provides a clean way to pass board configuration details
  # between classes, for example between the Parser and the
  # Board in order to initialize the Board state.
  class BoardConfiguration
    include Enumerable

    def initialize
      @pieces = []
    end

    # Adds a piece to the piece collection
    # Used by the object creating the configuration
    #
    # piece       - A sublass of Chess::Piece
    # coordinates - A coordinates instance
    #
    # Returns the BoardConfiguration instance
    def add_piece(piece, coordinates)
      @pieces << { :piece => piece, :coordinates => coordinates }
      self
    end

    # Iterates over the pieces
    # Used by the Board to configure itself
    def each
      @pieces.each do |piece|
        yield(piece)
      end
    end

    # Select the first configuration piece
    def first
      @pieces.first
    end
  end
end
