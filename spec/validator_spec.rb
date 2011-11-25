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
      # Chess.legal_move?(board, "a2", "a4").should be_true
      # # white pawn 3 up illegal
      # Chess.legal_move?(board, "a2", "a5").should be_false
      # # black pawn 1 down legal
      # Chess.legal_move?(board, "a7", "a6").shoud be_true
      # # black pawn 2 down (first move) legal
      # Chess.legal_move?(board, "a7", "a5").shoud be_true
      # # black pawn 3 down illegal
      # Chess.legal_move?(board, "a7", "a4").shoud be_false
      # # black pawn 1 down 1 right illegal
      # Chess.legal_move?(board, "a7", "b6").shoud be_false
      # # black knight 2 down 1 left legal
      # Chess.legal_move?(board, "b8", "a6").shoud be_false
      # # black knight 2 down 1 right legal
      # Chess.legal_move?(board, "b8", "c6").shoud be_false
      # # black knight move to spot occupied by team illegal
      # Chess.legal_move?(board, "b8", "d7").shoud be_false
      # # white pawn 1 up legal
      # Chess.legal_move?(board, "e2", "e3").shoud be_false
      # # no piece selected illegal
      # Chess.legal_move?(board, "e3", "e2").shoud be_false
    end
  end

  describe "rules" do
    class RuleClass
      include Chess::Rules
    end

    subject { RuleClass.new }
    describe "piece exists at origin" do
      it "returns true when there is a piece at the given coordinates" do
        subject.piece_exists_at_origin(board, "h1").should be_true
      end

      it "returns false when there is not a piece at the given coordinates" do
        subject.piece_exists_at_origin(board, "a5").should be_false
      end
    end
  end
end
