describe Chess::Parsers do
  describe Chess::Parsers::BoardParser do
    describe "parse" do
      it "should return a new configuration file with the parsed data" do
        config = Chess::Parsers::BoardParser.parse(start_board)
        config.first[:piece].should be_kind_of Chess::Pieces::Rook
        config.first[:coordinates].column.should == 0
        config.first[:coordinates].row.should == 7
      end
    end
  end

  describe Chess::Parsers::MoveParser do
    let(:simple_moves) { File.open("spec/data/simple_moves.txt").read }
    let(:complex_moves) { File.open("spec/data/complex_moves.txt").read }
		let(:config) { Chess::Parsers::BoardParser.parse(complex_board) }
    let(:board)  { Chess::Board.new(config) }

    describe "parse" do
      it "should return an array of hash's" do
        moves = Chess::Parsers::MoveParser.parse(simple_moves)
      end
    end

    # describe "complex moves" do
    #   it "should print the results for me" do
    #     moves = Chess::Parsers::MoveParser.parse(complex_moves)
    #     moves.each do |move|
    #       if Chess.legal_move?(board, move[:origin], move[:destination])
    #         puts "LEGAL"
    #       else
    #         puts "ILLEGAL"
    #       end
    #     end
    #   end
    # end
  end
end
