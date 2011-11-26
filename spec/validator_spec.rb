describe Chess::Validator do
  let(:start_board) { %Q[ bR bN bB bQ bK bB bN bR
                          bP bP bP bP bP bP bP bP
                          -- -- -- -- -- -- -- --
                          -- -- -- -- -- -- -- --
                          -- -- -- -- -- -- -- --
                          -- -- -- -- -- -- -- --
                          wP wP wP wP wP wP wP wP
                          wR wN wB wQ wK wB wN wR ] }
  let(:config) { Chess::Parsers::BoardParser.parse(start_board) }
  let(:board)  { Chess::Board.new(config) }

  describe "overall acceptance test of sample data" do
    it "should pass the simple data tests" do
      # white pawn 1 up legal
      Chess.legal_move?(board, "a2", "a3").should be_true

      # white pawn two up (first move) legal
      Chess.legal_move?(board, "a2", "a4").should be_true

      # white pawn 3 up illegal
      Chess.legal_move?(board, "a2", "a5").should be_false
      #
      # # black pawn 1 down legal
      Chess.legal_move?(board, "a7", "a6").should be_true
      #
      # # black pawn 2 down (first move) legal
      Chess.legal_move?(board, "a7", "a5").should be_true
      #
      # # black pawn 3 down illegal
      Chess.legal_move?(board, "a7", "a4").should be_false
      #
      # # black pawn 1 down 1 right illegal
      Chess.legal_move?(board, "a7", "b6").should be_false
      #
      # black knight 2 down 1 left legal
      Chess.legal_move?(board, "b8", "a6").should be_true
      #
      # black knight 2 down 1 right legal
      Chess.legal_move?(board, "b8", "c6").should be_true
      #
      # black knight move to spot occupied by team illegal
      Chess.legal_move?(board, "b8", "d7").should be_false
      #
      # white pawn 1 up legal
      Chess.legal_move?(board, "e2", "e3").should be_true
      #
      # no piece selected illegal
      Chess.legal_move?(board, "e3", "e2").should be_false
    end
  end

  describe "bootstrap!" do
    it "should return a falsey value if not within boundaries" do
      Chess::Validator.bootstrap!(board, "z11", "q12", Chess::Notations::AlgebraicNotation).should be_false
    end

    it "should return a truthy value if within within boundaries" do
      Chess::Validator.bootstrap!(board, "c1", "b8", Chess::Notations::AlgebraicNotation).should be_true
    end
  end


end
