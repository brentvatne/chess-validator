describe Chess::Pieces do

  describe Chess::Pieces::Pawn do
    let(:white_pawn) { Chess::Pieces::Pawn.new(:white) }
    let(:black_pawn) { Chess::Pieces::Pawn.new(:black) }
    let(:position) { Chess::Coordinates.new(4, 4) }
    let(:white_start) { Chess::Coordinates.new(1, 1) }
    let(:black_start) { Chess::Coordinates.new(6, 1) }
    let(:enemy) { Chess::Pieces::Pawn.new(:black) }

    describe "moves" do
      it "should be able to move one row up if white" do
        white_pawn.moves(position).should include(Chess::Move.new(1, 0))
      end

      it "should be able to move one row down if black" do
        black_pawn.moves(position).should include(Chess::Move.new(-1, 0))
      end

      describe "first move" do
        it "should be able to move two rows up if white" do
          white_pawn.moves(white_start).should include(Chess::Move.new(2, 0))
        end

        it "should be able to move two rows down if black" do
          black_pawn.moves(black_start).should include(Chess::Move.new(-2, 0))
        end
      end

      describe "enemy in diagonal" do
        it "should be able to move one row up and one row left" do
          white_pawn.moves(position, enemy).should include(Chess::Move.new(1, 1))
        end
      end
    end
  end
end
