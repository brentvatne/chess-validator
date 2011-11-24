module Chess
  class BoardConfiguration
    include Enumerable

    def initialize
      @pieces = []
    end

    # Adds a piece to the piece collection
    # Used by the object creating the configuration
    #
    # x     - An Integer between 0-7
    # y     - An Integer between 0-7
    # piece - A Hash => { :color => :x, :piece => :y }
    #
    # Returns the BoardConfiguration instance
    def add_piece(x, y, piece)
      piece[:x] = x; piece[:y] = y
      @pieces << piece
      self
    end

    # Iterates over the pieces
    # Used by the Board to configure itself
    def each
      @pieces.each do |piece|
        yield(piece)
      end
    end
  end
end
