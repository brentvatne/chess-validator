$LOAD_PATH.unshift(File.dirname(__FILE__))

# Note: Load order matters.
require 'chess/pieces'
require 'chess/notations'
require 'chess/parsers'
require 'chess/board_configuration'
require 'chess/board'
require 'chess/rules'
require 'chess/validator'
