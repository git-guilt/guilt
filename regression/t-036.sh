#!/usr/bin/env bash
#
# Test the rename code
#

source "$REG_DIR/scaffold"

cmd setup_repo

# invalid character
shouldfail guilt rename add add:2

# not-existing patch
shouldfail guilt rename addx addx2

# ok
cmd guilt rename add add2

cmd guilt series

cmd guilt push --all

cmd guilt applied

# rename an existings one
cmd guilt rename remove remove2
cmd guilt applied
cmd guilt top

# check we can pop and push the one we removed
cmd guilt pop
cmd guilt pop
cmd guilt push
cmd guilt applied
