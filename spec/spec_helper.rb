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

