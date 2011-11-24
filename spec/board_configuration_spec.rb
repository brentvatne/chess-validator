describe Chess::BoardConfiguration do

  subject { Chess::BoardConfiguration.new }
  let(:sample_piece) { {:color => :white, :piece => :pawn} }

  before do
    subject.add_piece(0, 0, sample_piece)
  end

  describe "add_piece" do
    it "should add the piece to the configuration" do
      subject.each do |e|
        e[:color].should == sample_piece[:color]
        e[:piece].should == sample_piece[:piece]
        e[:x].should == 0
        e[:y].should == 0
      end
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
