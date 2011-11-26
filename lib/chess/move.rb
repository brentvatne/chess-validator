module Chess
  Coordinates = Struct.new(:column, :row)

  class Move < Coordinates; end
end
