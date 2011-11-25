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
      # Chess.legal_move?(board, "a2", "a3").should be_true
      #
      # white pawn two up (first move) legal
      # Chess.legal_move?(board, "a2", "a4").should be_true
      #
      # # white pawn 3 up illegal
      # Chess.legal_move?(board, "a2", "a5").should be_false
      #
      # # black pawn 1 down legal
      # Chess.legal_move?(board, "a7", "a6").should be_true
      #
      # # black pawn 2 down (first move) legal
      # Chess.legal_move?(board, "a7", "a5").should be_true
      #
      # # black pawn 3 down illegal
      # Chess.legal_move?(board, "a7", "a4").should be_false
      #
      # # black pawn 1 down 1 right illegal
      # Chess.legal_move?(board, "a7", "b6").should be_false
      #
      # # black knight 2 down 1 left legal
      # Chess.legal_move?(board, "b8", "a6").should be_false
      #
      # # black knight 2 down 1 right legal
      # Chess.legal_move?(board, "b8", "c6").should be_false
      #
      # black knight move to spot occupied by team illegal
      Chess.legal_move?(board, "b8", "d7").should be_false
      #
      # # white pawn 1 up legal
      # Chess.legal_move?(board, "e2", "e3").should be_false
      #
      # no piece selected illegal
      Chess.legal_move?(board, "e3", "e2").should be_false
    end
  end

  describe "rules" do
    class RuleClass
      include Chess::Rules

      def initialize
        @notation = Chess::AlgebraicNotation
      end
    end

    subject { RuleClass.new }

    describe "cells within board boundaries" do
      it "should return a falsey value if not within boundaries" do
        subject.cells_within_board_boundaries("z11", "q12").should be_false
      end

      it "should return a truthy value if within within boundaries" do
        subject.cells_within_board_boundaries("c1", "b8").should be_true
      end
    end

    describe "piece exists at origin" do
      it "returns true when there is a piece at the given coordinates" do
        subject.piece_exists_at_origin(board, "h1").should be_true
      end

      it "returns false when there is not a piece at the given coordinates" do
        subject.piece_exists_at_origin(board, "a5").should be_false
      end

      it "raises an error when the coordinates are outside of the bounds" do
        expect { subject.piece_exists_at_origin(board, "z9") }.to raise_error
      end
    end

    describe "same team not occupying destination" do
      it "returns a truthy value if the destination piece on other team" do
        subject.same_team_not_occupying_destination(board, "a1", "b8").should be_true
      end

      it "returns a falsey value if destination piece is same team" do
        subject.same_team_not_occupying_destination(board, "a1", "a2").should be_false
      end
    end
  end
end
