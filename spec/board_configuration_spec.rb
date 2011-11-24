describe Chess::BoardConfiguration do

  subject { Chess::BoardConfiguration.new }
  let(:sample_piece)  { Chess::Pieces::Pawn.new(:white) }
  let(:sample_coords) { Chess::Coordinates.new(1, 2) }

  before do
    subject.add_piece(sample_piece, sample_coords)
  end

  describe "add_piece" do
    it "should add the piece to the configuration" do
      subject.first[:piece].should == sample_piece
      subject.first[:coordinates].should == sample_coords
    end
  end

  describe "each" do
    it "should yield a hash" do
      subject.each do |e|
        e.should be_kind_of Hash
      end
    end
  end
end
