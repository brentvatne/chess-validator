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
end
