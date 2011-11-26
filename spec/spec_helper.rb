require 'chess'
require 'rspec'

RSpec.configure do |c|
  c.mock_with :rspec
end

def new_move(x, y)
  Chess::Move.new(x, y)
end

