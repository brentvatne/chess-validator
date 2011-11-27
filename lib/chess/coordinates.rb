module Chess
	# A simple tuple to make passing around coordinates easier
  Coordinates = Struct.new(:column, :row)
	# Same as Coordinates, but named differently to reveal intention
  Move        = Struct.new(:column, :row)
end
