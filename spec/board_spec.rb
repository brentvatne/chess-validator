describe Chess::Board do

  let(:board)       { Chess::Board.new(config) }
  let(:empty_board) { Chess::Board.new(Chess::BoardConfiguration.new) }
  let(:config)      { Chess::BoardConfiguration.new }
  let(:piece)       { Chess::Pieces::Pawn.new(:white) }

  before do
    config.add_piece(piece, Chess::Coordinates.new(0, 0))
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
    let(:origin) { coords("a2") }
    let(:destination) { coords("b1") }

    before do
      board.add_piece(Chess::Pieces::Pawn.new(:white), origin)
      board.add_piece(Chess::Pieces::Rook.new(:white), destination)
    end

    it "moves the piece even if the destiantion is occupied" do
      moved_piece = board.at(origin)
      old_piece   = board.at(destination)
      board.move_piece! :from => origin, :to => destination
      board.at(destination).should == moved_piece
      board.at(destination).should_not == old_piece
    end

    it "empties the old spot" do
      moved_piece = board.at(origin)
      board.move_piece! :from => origin, :to => destination
      board.at(origin).should == :empty
    end
  end

	describe "king_position" do
		let(:black_king_position) { coords("b5") }
		let(:white_king_position) { coords("e6") }
		before do
			board.add_piece(Chess::Pieces::King.new(:black), black_king_position)
			board.add_piece(Chess::Pieces::King.new(:white), white_king_position)
		end

		it "should find the position of the white king" do
			board.king_position(:white).should == white_king_position
		end

		it "should find the position of the black king" do
			board.king_position(:black).should == black_king_position
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
