#!/usr/bin/env bash
#
# Test that all commands that should succeed when run from
# $GUILT_DIR/$branch do indeed succeed
#

source "$REG_DIR/scaffold"

cmd setup_repo

cmd guilt push

dir=.git/patches/master

cmd list_files
(cd $dir && cmd guilt applied)
cmd list_files
(cd $dir && cmd guilt commit -a)
cmd list_files

# Since "guilt commit -a" removed the only applied patch, we push
# another one.
cmd guilt push
cmd list_files

(cd $dir && cmd guilt delete mode)
cmd list_files
(cd $dir && cmd guilt export)
cmd list_files
(cd $dir && cmd guilt graph)
cmd list_files
(cd $dir && cmd guilt guard -l)
cmd list_files
(cd $dir && cmd guilt header)
cmd list_files
# Redirect stdout to /dev/null; we don't want to have to update
# t-014.out every time the man-page changes.
(cd $dir && cmd_silent guilt help)
(cd $dir && cmd guilt next)

# We only get interesting output from "guilt prev" when there are at
# least two patches applied, so push one more during this test.
cmd guilt push
(cd $dir && cmd guilt prev)
cmd guilt pop

(cd $dir && cmd guilt series)
(cd $dir && cmd guilt top)
(cd $dir && cmd guilt unapplied)
cmd list_files
