require 'chess'
require 'rspec'

RSpec.configure do |c|
  c.mock_with :rspec
end

def new_move(x, y)
  Chess::Move.new(x, y)
end

def coords(alg)
  Chess::Notations::AlgebraicNotation.translate_position(alg)
end

def start_board
  %Q[ bR bN bB bQ bK bB bN bR
      bP bP bP bP bP bP bP bP
      -- -- -- -- -- -- -- --
      -- -- -- -- -- -- -- --
      -- -- -- -- -- -- -- --
      -- -- -- -- -- -- -- --
      wP wP wP wP wP wP wP wP
      wR wN wB wQ wK wB wN wR ]
end

def complex_board
  %Q[ bK -- -- -- -- bB -- --
      -- -- -- -- -- bP -- --
      -- bP wR -- wB -- bN --
      wN -- bP bR -- -- -- wP
      -- -- -- -- wK wQ -- wP
      wR -- bB wN wP -- -- --
      -- wP bQ -- -- wP -- --
      -- -- -- -- -- wB -- -- ]
end
