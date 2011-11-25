describe Chess::AlgebraicNotation do

  subject { Chess::AlgebraicNotation }

  describe "translate_position" do
    it "should translate the column (eg: 'a') correctly" do
      subject.translate_position("b8").column.should == 1
    end
    it "should translate the row (eg: '1') correctly" do
      subject.translate_position("b8").row.should == 7
    end
    it "should be able to translate back to algebreaic notation" do
      pending 'in order to print the board out again'
    end
  end

  describe "translate_piece" do

    describe "invalid inputs" do
      it "raises an exception if the piece code (eg K) is invalid" do
        expect { subject.translate_piece("bZ") }.to raise_error ArgumentError
      end

      it "raises an exception if the color code (eg b) is invalid" do
        expect { subject.translate_piece("zP") }.to raise_error ArgumentError
      end

      it "raises an error if the codes are in the wrong case" do
        expect { subject.translate_piece("Bp") }.to raise_error ArgumentError
      end
    end

    it "should return a Piece" do
      subject.translate_piece("bR").should be_kind_of Chess::Pieces::Piece
    end


    it "should translate color" do
      subject.translate_piece("bR").color.should == :black
      subject.translate_piece("wR").color.should == :white
    end

    it "should translate pawns" do
      subject.translate_piece("wP").should be_a Chess::Pieces::Pawn
    end

    it "should translate knights" do
      subject.translate_piece("wN").should be_a Chess::Pieces::Knight
    end

    it "should translate bishops" do
      subject.translate_piece("wB").should be_a Chess::Pieces::Bishop
    end

    it "should translate rooks" do
      subject.translate_piece("wR").should be_a Chess::Pieces::Rook
    end

    it "should translate queens" do
      subject.translate_piece("wQ").should be_a Chess::Pieces::Queen
    end

    it "should translate kings" do
      subject.translate_piece("wK").should be_a Chess::Pieces::King
    end

    it "should be able to translate back to algebreaic notation" do
      pending 'in order to print the board out again'
    end
  end
end
