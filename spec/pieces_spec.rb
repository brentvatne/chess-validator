describe Chess::Pieces do

  describe Chess::Pieces::Pawn do
    let(:white_pawn)  { Chess::Pieces::Pawn.new(:white) }
    let(:black_pawn)  { Chess::Pieces::Pawn.new(:black) }
    let(:position)    { Chess::Coordinates.new(4, 4) }
    let(:white_start) { Chess::Coordinates.new(1, 1) }
    let(:black_start) { Chess::Coordinates.new(1, 6) }
    let(:enemy)       { Chess::Pieces::Pawn.new(:black) }

    describe "moves" do
      it "should be able to move one row up if white" do
        white_pawn.can_make_move?(Chess::Move.new(0, 1), position).should be_true
      end

      it "should be able to move one row down if black" do
        black_pawn.can_make_move?(Chess::Move.new(0, -1), position).should be_true
      end

      describe "first move" do
        it "should be able to move two rows up if white" do
          white_pawn.can_make_move?(Chess::Move.new(0, 2), white_start).should be_true
        end

        it "should be able to move two rows down if black" do
          black_pawn.can_make_move?(Chess::Move.new(0, -2), black_start).should be_true
        end
      end

      describe "enemy in diagonal" do
        it "should be able to move one row up and one row left or right, if white" do
          white_pawn.can_make_move?(Chess::Move.new(1, 1), position, enemy).should be_true
          white_pawn.can_make_move?(Chess::Move.new(-1, 1), position, enemy).should be_true
        end
        it "should be able to move one row up and one row left or right, if white" do
          black_pawn.can_make_move?(Chess::Move.new(1, -1), position, enemy).should be_true
          black_pawn.can_make_move?(Chess::Move.new(-1, -1), position, enemy).should be_true
        end
      end
    end
  end

  describe Chess::Pieces::Knight do
    let(:knight) { Chess::Pieces::Knight.new(:black) }

  end
end
