#!/usr/bin/env bash
#
# Test that all commands that should fail when run from
# $GUILT_DIR/$branch do indeed fail.  This file only tests command
# that need an argument to be useful.  See t-012.sh for an overview of
# how all commands handle being run from withing $GUILT_DIR/$branch.

source "$REG_DIR/scaffold"

# Setup a state where one patche is pushed.
cmd setup_repo
cmd guilt push

# Record the state.
cmd list_files

dir=.git/patches/master

(cd $dir && shouldfail guilt add series)
(cd $dir && shouldfail guilt goto remove)
(cd $dir && shouldfail guilt import remove)
(cd $dir && shouldfail guilt import-commit HEAD)
(cd $dir && shouldfail guilt new rejected-patch)
(cd $dir && shouldfail guilt rename mode chmod)
(cd $dir && shouldfail guilt rm mode)

# Check that no command above changed the state.
cmd list_files
