describe Chess::Board do

  let(:board) { Chess::Board.new(config) }
  let(:empty_board) { Chess::Board.new(Chess::BoardConfiguration.new) }
  let(:config) { Chess::BoardConfiguration.new }
  let(:piece) { Chess::Pieces::Pawn.new(:white) }

  before do
    coords = Chess::Coordinates.new(0, 0)
    config.add_piece(piece, coords)
  end

  describe "initialize" do
    it "places pieces from the configuration on the chess board" do
      board.at(0, 0).should == piece
    end

    it "creates a new 8x8 board" do
      empty_board.columns.length.should == 8
      empty_board.rows.length.should    == 8
    end
  end

  describe "move_piece!" do
    it "moves the piece even if the destiantion is occupied" do

    end
  end

  describe "at" do
    it "accepts algebraic notation" do
      board.at("a1").should == piece
    end

    it "accepts coordinates" do
      board.at(0, 0).should == piece
    end

    it "accepts Coordinates instances" do
      board.at(Chess::Coordinates.new(0,0)).should == piece
    end
  end

  describe "add_piece" do
    it "adds the piece at the given location" do
      new_piece = Chess::Pieces::King.new(:black)
      new_coords = Chess::Coordinates.new(6, 0)
      config.add_piece(new_piece, new_coords)
      new_board = Chess::Board.new(config)
      new_board.at("g1").should == new_piece
    end
  end
end
