# RMU Entrance Exam Jan, 2011 - PuzzleNode: Chess Validator
### Brent Vatne

## Notes for the reviewers
Hi there! Thanks for reading. I recommend checking out the Read the code
section below for my suggested path through the code, and what to watch
out for.

## Run the tests
Uses Rspec, to run the suite: `bundle install && rake`
*Tested with Ruby 1.9.3p0*

## Use it

````ruby
require 'chess'

# Load board (subtitue board.txt for your file)
board_config = Chess::Parsers::BoardParser.parse(File.open("board.txt").read)
board        = Chess::Board.new(board_config)

Chess::Validator.legal?("a3", "a6")

# Load moves (substitute moves.txt for you file)
moves = Chess::Parsers::MoveParser.parse(File.open("moves.txt").read)

Chess::Validator.legal?(moves.first.origin, moves.first.destination)
````

Or you can use `/bin/validate_moves` from the command line:

`ruby bin/validate_moves full_path_to_board_file full_path_to_moves_file`

Use the shortcuts to load the example data!

`ruby bin/validate_moves simple`

`ruby bin/validate_moves complex`

## Read the code
First, I'd suggest quickly scanning the Board, and Notations files. I
would not bother with the parsers. Next, I suggest reading through Pieces,
to get an understanding of what the Pieces know about themselves. Notice
that all information about location on the board is within the domain of
the Board class, while a Piece simply knows what moves it is capable of
doing.

Next, to understand how the rules are applied, check out Validator,
followed by Rules. The check_legality method is pretty cool I think -
each component method evaluates its own part of the rule equation,
independent of what the other parts have determined.

Extensive documentation has been provided inline, roughly according to
the TomDoc specification - http://tomdoc.org/
The code may seem verbose because of the comments, or maybe it just is
verbose to begin with. Either way, I hope that if I am accepted into
RbMU to be able to improve my ability to write concise code and
comments. Lastly, I hope you find my comments useful and thanks again
for reading! Any feedback is much appreciated.

## Extend it
Add your own Notations that implement the same interface as
AlgebraicNotation, and just pass it in with a new instance of a board.

`board = Chess::Board.new(state, MySpecialNotation)`
