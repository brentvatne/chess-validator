describe Chess::Rules do
  let(:start_board) { %Q[ bR bN bB bQ bK bB bN bR
                          bP bP bP bP bP bP bP bP
                          -- -- -- -- -- -- -- --
                          -- -- -- -- -- -- -- --
                          -- -- -- -- -- -- -- --
                          -- -- -- -- -- -- -- --
                          wP wP wP wP wP wP wP wP
                          wR wN wB wQ wK wB wN wR ] }
  let(:config)   { Chess::Parsers::BoardParser.parse(start_board) }
  let(:board)    { Chess::Board.new(config) }
  let(:notation) { Chess::Notations::AlgebraicNotation }

  class RuleTestClass
    include Chess::Rules

    attr_reader :board, :origin, :destination, :piece

    def initialize(board)
      @board = board
    end

    def using(origin, destination="h1")
      @origin = coords(origin)
      @destination = coords(destination)
      @piece = board.at(@origin)
    end
  end

  subject { RuleTestClass.new(board) }

  describe "open_path_to_destination" do
    describe "covered by other logic" do
      it "does not care if a piece exists in the destination cell" do
        subject.using("a1", "a2")
        subject.open_path_to_destination.should be_true
      end

      it "does not care about the direction" do
        subject.using("a1", "a2")
        subject.open_path_to_destination.should be_true
        subject.using("a2", "a1")
        subject.open_path_to_destination.should be_true
      end
    end
    describe "blockable movement" do
      it "should return true when there is no piece obstructing path" do
        subject.using("a2", "a3")
        subject.open_path_to_destination.should be_true
      end

      it "should return false if there is a piece in between the origin and the destination" do
        subject.using("a1", "a3")
        subject.open_path_to_destination.should be_false
      end
    end
    describe "right next door" do
      it "should always return true if the cell is just one movement away,
          both straight and diagonally" do
        subject.using("a2", "b3")
        subject.open_path_to_destination.should be_true
        subject.using("a4", "a3")
        subject.open_path_to_destination.should be_true
      end
    end
    describe "unblockable movement - knights" do
      it "should always return true if the movement is like a knight's" do
        subject.using("a2", "b3")
        subject.open_path_to_destination.should be_true
      end
    end
  end

  describe "piece_exists_at_origin" do
    it "returns true when there is a piece at the given coordinates" do
      subject.using("a2")
      subject.piece_exists_at_origin.should be_true
    end

    it "returns false when there is not a piece at the given coordinates" do
      subject.using("a5")
      subject.piece_exists_at_origin.should be_false
    end
  end

  describe "same_team_not_occupying_destination" do
    it "returns a truthy value if the destination piece on other team" do
      subject.using("a1", "b8")
      subject.same_team_not_occupying_destination.should be_true
    end

    it "returns a falsey value if destination piece is same team" do
      subject.using("a1", "a2")
      subject.same_team_not_occupying_destination.should be_false
    end

    it "returns a truthy value if the destination is empty" do
      subject.using("a1", "a4")
      subject.same_team_not_occupying_destination.should be_true
    end
  end
end
