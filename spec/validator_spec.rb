describe Chess::Validator do
  let(:board)  { Chess::Board.new(config) }

  describe "manual testing examples from complex board" do
		let(:config) { Chess::Parsers::BoardParser.parse(complex_board) }
    it "should pass these tests" do
      # b2 b3 - white pawn 1 up legal
      Chess::Validator.legal?(board, "b2", "b3").should be_true

      # f2 b7 - white pawn 5 up 4 left illegal
      Chess::Validator.legal?(board, "f2", "b7").should be_false

      # b4 a8 - nothing on b4 illegal
      Chess::Validator.legal?(board, "b4", "a8").should be_false

      # a8 g5 - black king 6 right 3 down illegal
      Chess::Validator.legal?(board, "a8", "g5").should be_false

      # b2 b4 - white pawn 2 up (first move) legal
      Chess::Validator.legal?(board, "b2", "b4").should be_true

      # h7 f6 - nothing on h7 illegal
      Chess::Validator.legal?(board, "h7", "f6").should be_false

      # e3 b1 - white pawn backwards many left many illegal
      Chess::Validator.legal?(board, "e3", "b1").should be_false

      # b7 e4 - nothing on b7 illegal
      Chess::Validator.legal?(board, "b7", "e4").should be_false

      # b2 b5 - white pawn 3 up illegal
      Chess::Validator.legal?(board, "b2", "b5").should be_false

      # g7 g2 - nothing on g7 illegal
      Chess::Validator.legal?(board, "g7", "g2").should be_false

      # f7 f8 - black pawn 1 up illegal
      Chess::Validator.legal?(board, "f7", "f8").should be_false

      # g7 e8 - nothing on g7
      Chess::Validator.legal?(board, "g7", "e8").should be_false
    end
  end

  describe "overall acceptance test of sample data" do
  let(:config) { Chess::Parsers::BoardParser.parse(start_board) }

    it "should pass the simple data tests" do
      # white pawn 1 up legal
      # Chess::Validator.legal?(board, "a2", "a3").should be_true

      # white pawn two up (first move) legal
      Chess::Validator.legal?(board, "a2", "a4").should be_true

      # white pawn 3 up illegal
      Chess::Validator.legal?(board, "a2", "a5").should be_false
      #
      # # black pawn 1 down legal
      Chess::Validator.legal?(board, "a7", "a6").should be_true
      #
      # # black pawn 2 down (first move) legal
      Chess::Validator.legal?(board, "a7", "a5").should be_true
      #
      # # black pawn 3 down illegal
      Chess::Validator.legal?(board, "a7", "a4").should be_false
      #
      # # black pawn 1 down 1 right illegal
      Chess::Validator.legal?(board, "a7", "b6").should be_false
      #
      # black knight 2 down 1 left legal
      Chess::Validator.legal?(board, "b8", "a6").should be_true
      #
      # black knight 2 down 1 right legal
      Chess::Validator.legal?(board, "b8", "c6").should be_true
      #
      # black knight move to spot occupied by team illegal
      Chess::Validator.legal?(board, "b8", "d7").should be_false
      #
      # white pawn 1 up legal
      Chess::Validator.legal?(board, "e2", "e3").should be_true
      #
      # no piece selected illegal
      Chess::Validator.legal?(board, "e3", "e2").should be_false
    end
  end
end
