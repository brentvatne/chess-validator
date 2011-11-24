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
      subject.translate_piece("wP")[:type].should == :pawn

    end
    it "should translate knights" do
      subject.translate_piece("wN")[:type].should == :knight

    end
    it "should translate bishops" do
      subject.translate_piece("wB")[:type].should == :bishop

    end
    it "should translate rooks" do
      subject.translate_piece("wR")[:type].should == :rook

    end
    it "should translate queens" do
      subject.translate_piece("wQ")[:type].should == :queen
    end
    it "should translate kings" do
      subject.translate_piece("wK")[:type].should == :king
    end
  end
end
