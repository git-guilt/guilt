#!/usr/bin/env bash
#
# Test the fork code
#

source "$REG_DIR/scaffold"

cmd setup_repo

cmd guilt push -n 2

cmd list_files
 
shouldfail guilt fork mode

cmd list_files
 
# add a comment and start spaces to last patch in the series
# to detects a bug inserting patches in the series
sed 's,^add,  add  #  comment,' < .git/patches/master/series > .git/patches/master/series.tmp
mv .git/patches/master/series.tmp .git/patches/master/series
cmd grep ' add ' .git/patches/master/series

cmd guilt fork foobar

cmd list_files

# Without an argument, fork derives the new name from the old one.
cmd guilt fork
cmd guilt top
cmd guilt new p-08.patch
cmd guilt fork
cmd guilt top
cmd guilt new q-9
cmd guilt fork
cmd guilt top
cmd guilt series
