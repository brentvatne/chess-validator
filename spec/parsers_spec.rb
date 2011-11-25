describe Chess::Parsers do
  let(:board) { %Q[ bR bN bB bQ bK bB bN bR
                    bP bP bP bP bP bP bP bP
                    -- -- -- -- -- -- -- --
                    -- -- -- -- -- -- -- --
                    -- -- -- -- -- -- -- --
                    -- -- -- -- -- -- -- --
                    wP wP wP wP wP wP wP wP
                    wR wN wB wQ wK wB wN wR ] }

  describe Chess::Parsers::BoardParser
    describe "parse" do
      it "should return a new configuration file with the parsed data" do
        config = Chess::Parsers::BoardParser.parse(board)
        config.first[:piece].should be_kind_of Chess::Pieces::Rook
        config.first[:coordinates].column.should == 0
        config.first[:coordinates].row.should == 7
      end
    end
end
