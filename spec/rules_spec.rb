describe Chess::Rules do
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
      @piece = board.piece_at(@origin)
    end
  end

  subject { RuleTestClass.new(board) }

  describe "previously incorrect tests" do
    let(:config)   { Chess::Parsers::BoardParser.parse(complex_board) }
    subject { RuleTestClass.new(board) }

    it "should not fail on this example (rook 2 left over top of its own)" do
      subject.using("d5", "b5")
      # col diff = 2
      # row diff = 0
      subject.open_path_to_destination.should be_false
    end

    it "should not fail on this example (queen all the way across the board)" do
      subject.using("c2", "e7")
      subject.open_path_to_destination.should be_false
      # problem is it is not fitting in the categories?
    end

    it "should not fail on this example (queen moving up over two if its own pieces)" do
      subject.using("c2", "c6")
      subject.open_path_to_destination.should be_false
    end

    it "should not fail on this example (queen moving up over one of its team maters)" do
      subject.using("c2", "c4")
      subject.open_path_to_destination.should be_false
    end

    describe "king_would_remain_safe" do
      it "should be false if the king is exposed to danger" do
        subject.using("a8", "g5")
        subject.king_would_remain_safe.should be_false
      end

      it "should not fail on this example (king to vulnerable position)" do
        subject.using("e4", "e5")
        subject.king_would_remain_safe.should be_false
      end

      it "should be true if the king would remain safe" do
        subject.using("a8", "a7")
        subject.king_would_remain_safe.should be_true
      end
    end
  end

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
        subject.using("c1", "c6")
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
