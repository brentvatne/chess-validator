describe Chess::AlgebraicNotation do

  subject { Chess::AlgebraicNotation }

  describe "translate_position" do

  end

  describe "translate_piece" do
    it "should return a hash" do
      subject.translate_piece("bR").should be_kind_of Hash
    end

    it "should translate color" do
      subject.translate_piece("bR")[:color].should == :black
      subject.translate_piece("wR")[:color].should == :white
    end

    it "should translate pawns" do
      subject.translate_piece("wP")[:piece].should == :pawn

    end
    it "should translate knights" do
      subject.translate_piece("wN")[:piece].should == :knight

    end
    it "should translate bishops" do
      subject.translate_piece("wB")[:piece].should == :bishop

    end
    it "should translate rooks" do
      subject.translate_piece("wR")[:piece].should == :rook

    end
    it "should translate queens" do
      subject.translate_piece("wQ")[:piece].should == :queen
    end
    it "should translate kings" do
      subject.translate_piece("wK")[:piece].should == :king
    end
  end
end
