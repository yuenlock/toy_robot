Multiplayer Toy Robot
===========================

To install, clone this repository and then run

    bundle install

To run tests

    bundle exec rspec

To run

    bin/play_game.rb <filename>

Contents of the file should be in the format of

    Name: Command <Args>

Accepted actions are

| Command | Arguments    | Action taken |
|---------|--------------|--------------|
|PLACE    | X,Y,DIRECTION | Places robot on coordinates X, Y, Facing DIRECTION|
|MOVE     |  | Moves Robot 1 square forward in DIRECTION |
|LEFT     |  | Rotates Robot 90 degrees anti-clockwise |
|RIGHT    |  | Rotates Robot 90 degrees clockwise |
|REPORT   |  | Reports Robot position as a string X,Y,DIRECTION|

Accepted arguments for the PLACE command are
- `X` between `0` and `5`
- `Y` between `0` and `5`
- `DIRECTIONS` are either `NORTH`, `EAST`, `SOUTH` or `WEST`

### Sample
Below is the content of a sample file (found in `./data/two_player_02.txt`)

    BOB: PLACE 1,3,SOUTH
    ALICE: PLACE 0,1,EAST
    ALICE: MOVE
    BOB: MOVE
    BOB: MOVE
    ALICE: MOVE
    BOB: MOVE
    BOB: LEFT
    ALICE: REPORT
    BOB: REPORT

And the output will be

    ALICE: 2,1,EAST
    BOB: 1,1,EAST

More sample command files are in the `./data` directory

Regular Toy Robot
-----------------
The regular ToyRobot can still be run via

    bin/play.rb <filename>

And the file contents should look like

    PLACE 1,2,EAST
    MOVE
    LEFT
    MOVE
    REPORT

and the output will be

    2,3,NORTH

