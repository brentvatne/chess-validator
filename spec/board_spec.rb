describe Chess::Board do

  let(:board)       { Chess::Board.new(config) }
  let(:empty_board) { Chess::Board.new([]) }
  let(:config)      { [] }
  let(:piece)       { Chess::Pieces::Pawn.new(:white) }

  before do
    config << { :piece => piece, :coordinates => coords("a1") }
  end

  describe "initialize" do
    it "places pieces from the configuration on the chess board" do
      board.piece_at(0, 0).should == piece
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
      board.put_piece(Chess::Pieces::Pawn.new(:white), origin)
      board.put_piece(Chess::Pieces::Rook.new(:white), destination)
    end

    it "moves the piece even if the destiantion is occupied" do
      moved_piece = board.piece_at(origin)
      old_piece   = board.piece_at(destination)
      board.move_piece! :from => origin, :to => destination
      board.piece_at(destination).should == moved_piece
      board.piece_at(destination).should_not == old_piece
    end

    it "empties the old spot" do
      moved_piece = board.piece_at(origin)
      board.move_piece! :from => origin, :to => destination
      board.piece_at(origin).should == :empty
    end
  end

	describe "king_position" do
		let(:black_king_position) { coords("b5") }
		let(:white_king_position) { coords("e6") }
		before do
			board.put_piece(Chess::Pieces::King.new(:black), black_king_position)
			board.put_piece(Chess::Pieces::King.new(:white), white_king_position)
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
      board.piece_at("a1").should == piece
    end

    it "accepts coordinates" do
      board.piece_at(0, 0).should == piece
    end

    it "accepts Coordinates instances" do
      board.piece_at(Chess::Coordinates.new(0,0)).should == piece
    end
  end

  describe "put_piece" do
    it "adds the piece at the given location" do
      new_piece = Chess::Pieces::King.new(:black)
      config << { :piece => new_piece, :coordinates => coords("g1") }
      new_board = Chess::Board.new(config)
      new_board.piece_at("g1").should == new_piece
    end
  end
end
