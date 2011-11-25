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

  class RuleTestClass
    include Chess::Rules

    def initialize
      @notation = Chess::AlgebraicNotation
    end
  end

  subject { RuleTestClass.new }

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
