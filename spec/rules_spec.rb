describe Chess::Rules do
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
  let(:notation) { Chess::Notations::AlgebraicNotation }

  class RuleTestClass
    include Chess::Rules

    def initialize
      @notation = Chess::Notations::AlgebraicNotation
    end
  end

  subject { RuleTestClass.new }

  describe "" do
    describe "covered by other logic" do
      it "does not care if a piece exists in the destination cell" do
        subject.open_path_to_destination(board, coords("a1"), coords("a2")).should be_true
      end

      it "does not care about the direction" do
        subject.open_path_to_destination(board, coords("a1"), coords("a2")).should be_true
        subject.open_path_to_destination(board, coords("a2"), coords("a1")).should be_true
      end
    end
    describe "blockable movement" do
      it "should return true when there is no piece obstructing path" do
        subject.open_path_to_destination(board, coords("a2"), coords("a3")).should be_true
      end

      it "should return false if there is a piece in between the origin
          and the destination" do
        subject.open_path_to_destination(board, coords("a1"), coords("a3")).should be_false
      end
    end
    describe "right next door" do
      it "should always return true if the cell is just one movement away,
          both straight and diagonally" do
          subject.open_path_to_destination(board, coords("a2"), coords("b3")).should be_true
          subject.open_path_to_destination(board, coords("a4"), coords("a3")).should be_true
      end
    end
    describe "unblockable movement - knights" do
      it "should always return true if the movement is like a knight's" do
        subject.open_path_to_destination(board, coords("a2"), coords("b3")).should be_true
      end
    end
  end

  describe "piece_exists_at_origin" do
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

  describe "same_team_not_occupying_destination" do
    it "returns a truthy value if the destination piece on other team" do
      subject.same_team_not_occupying_destination(board, "a1", "b8").should be_true
    end

    it "returns a falsey value if destination piece is same team" do
      subject.same_team_not_occupying_destination(board, "a1", "a2").should be_false
    end

    it "returns a truthy value if the destination is empty" do
      subject.same_team_not_occupying_destination(board, "a1", "a4").should be_true
    end
  end
end
