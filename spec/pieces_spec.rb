describe Chess::Pieces do

  describe Chess::Pieces::Pawn do
    let(:white_pawn)  { Chess::Pieces::Pawn.new(:white) }
    let(:black_pawn)  { Chess::Pieces::Pawn.new(:black) }
    let(:position)    { Chess::Coordinates.new(4, 4) }
    let(:white_start) { Chess::Coordinates.new(1, 1) }
    let(:black_start) { Chess::Coordinates.new(1, 6) }
    let(:enemy)       { Chess::Pieces::Pawn.new(:black) }

    describe "can_make_move?" do
      it "should be able to move one row up if white" do
        white_pawn.can_make_move?(new_move(0, 1), position).should be_true
      end

      it "should be able to move one row down if black" do
        black_pawn.can_make_move?(new_move(0, -1), position).should be_true
      end

      describe "first move" do
        it "should be able to move two rows up if white" do
          white_pawn.can_make_move?(new_move(0, 2), white_start).should be_true
        end

        it "should be able to move two rows down if black" do
          black_pawn.can_make_move?(new_move(0, -2), black_start).should be_true
        end
      end

      describe "enemy in diagonal" do
        it "should be able to move one row up and one row left or right, if white" do
          white_pawn.can_make_move?(new_move(1, 1), position, enemy).should be_true
          white_pawn.can_make_move?(new_move(-1, 1), position, enemy).should be_true
        end
        it "should be able to move one row up and one row left or right, if white" do
          black_pawn.can_make_move?(new_move(1, -1), position, enemy).should be_true
          black_pawn.can_make_move?(new_move(-1, -1), position, enemy).should be_true
        end
      end
    end
  end

  describe Chess::Pieces::Knight do
    let(:knight) { Chess::Pieces::Knight.new(:black) }

    describe "can_make_move?" do
      it "should be able to move in an L shape in any direction" do
        knight.can_make_move?(new_move(-2, 1)).should be_true
      end
    end
  end

  describe Chess::Pieces::Rook do
    let(:rook) { Chess::Pieces::Rook.new(:white) }

    describe "can_make_move?" do
      it "should be able to move any number of spaces up" do
        (1..7).each do |n|
          rook.can_make_move?(new_move(0, n)).should be_true
        end
      end
      it "should be able to move any number of spaces down" do
        (1..7).each do |n|
          rook.can_make_move?(new_move(0, -1 * n)).should be_true
        end
      end
      it "should be able to move any number of spaces left" do
        (1..7).each do |n|
          rook.can_make_move?(new_move(-1 * n, 0)).should be_true
        end
      end
      it "should be able to move any number of spaces right" do
        (1..7).each do |n|
          rook.can_make_move?(new_move(n, 0)).should be_true
        end
      end
    end
  end

  describe Chess::Pieces::Bishop do
    let(:bishop) { Chess::Pieces::Bishop.new(:white) }

    describe "can_make_move?" do
      it "should be able to move diagonally any number of cells" do
        bishop.can_make_move?(new_move(3,3)).should be_true
        bishop.can_make_move?(new_move(-3,3)).should be_true
        bishop.can_make_move?(new_move(3,-3)).should be_true
        bishop.can_make_move?(new_move(-3,-3)).should be_true
      end
    end
  end

  describe Chess::Pieces::Queen do
    let(:queen) { Chess::Pieces::Queen.new(:white) }

    describe "can_make_move?" do
      it "should be able to move diagonally any number of cells" do
        queen.can_make_move?(new_move(3,3)).should be_true
        queen.can_make_move?(new_move(-3,3)).should be_true
        queen.can_make_move?(new_move(3,-3)).should be_true
        queen.can_make_move?(new_move(-3,-3)).should be_true
      end

      it "should be able to move straight any number of cells" do
        queen.can_make_move?(new_move(3,0)).should be_true
        queen.can_make_move?(new_move(-3,0)).should be_true
        queen.can_make_move?(new_move(0,-3)).should be_true
        queen.can_make_move?(new_move(0,-3)).should be_true
      end
    end
  end

  describe Chess::Pieces::King do
    let(:king) { Chess::Pieces::King.new(:white) }

    describe "can_make_move?" do
      it "should be able to move up, down, left, or right by 1" do
        king.can_make_move?(new_move(1,0)).should be_true
        king.can_make_move?(new_move(0,1)).should be_true
        king.can_make_move?(new_move(-1,0)).should be_true
        king.can_make_move?(new_move(0,-1)).should be_true
        king.can_make_move?(new_move(1,1)).should be_true
        king.can_make_move?(new_move(-1,-1)).should be_true
      end
    end
  end
end
