describe Chess::Parsers do
  let(:board) { %Q[ bR bN bB bQ bK bB bN bR
                    bP bP bP bP bP bP bP bP
                    -- -- -- -- -- -- -- --
                    -- -- -- -- -- -- -- --
                    -- -- -- -- -- -- -- --
                    -- -- -- -- -- -- -- --
                    wP wP wP wP wP wP wP wP
                    wR wN wB wQ wK wB wN wR ] }

 it "should print the board" do
   puts board.split("\n").map(&:split)
 end
end
